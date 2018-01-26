//
//  MessageController.swift
//  App
//
//  Created by 牛辉 on 2017/12/31.
//

import Foundation
import Vapor

struct MessageServer: ServerProrocol {

    func registered() {
        let key = "\(IM_BaseDefine_ServiceID.sidMsg.rawValue)-\(IM_BaseDefine_MessageCmdID.cidMsgData.rawValue)"
        servers[key] = self
    }
    func route(_ header: apiHeader, _ ws: WebSocket, _ contentData: Data) {
        do {
            //单聊
            var msg = try IM_Message_IMMsgData(serializedData: contentData)
            //1.保存msg到数据库
            let message = try saveMessage(&msg)
            //2.处理session
            if msg.to.contains("g_") {//群
                try groupSession(header, msg, message: message)
            } else {
                try singleSession(msg, message: message)
                //3.先转发给to
                try msgForward(header, msg)
            }
            //4.返回ack
            try msgAck(ws, header, msg: msg)
            
        } catch {
            print(error)
        }
    }
    func saveMessage(_ msg:inout IM_Message_IMMsgData) throws -> Message {
        let message = Message(msg)
        var count = 0
        if msg.to.contains("g_") {//群
            count = try Message.makeQuery().filter("to", msg.to).count()
        } else {
            count = try message.makeQuery().or({ (orQuery) in
                try orQuery.filter("form", msg.from).filter("to", msg.to)
                try orQuery.filter("form", msg.to).filter("to", msg.from)
            }).count()
        }
        message.msg_id = count + 1
        msg.msgID = "\(message.msg_id)"
        msg.createTime = UInt32(message.create_time)
        try message.save()
        return message
    }
    func singleSession(_ msg: IM_Message_IMMsgData, message: Message) throws {
        //1.发送方的session
        if let fromSession = try Session.makeQuery().filter("user_id", msg.from).filter("cid", msg.to).first() {
            fromSession.msg_id = message.msg_id
            fromSession.update_at = message.create_time
            fromSession.unread += 1
            try fromSession.save()
        } else {
            let session = Session(msg.from, cid: msg.to, type: 1, msg_id: message.msg_id)
            session.unread += 1
            try session.save()
        }
        //2.接受方的session
        if let toSession = try Session.makeQuery().filter("user_id", msg.to).filter("cid", msg.from).first() {
            toSession.msg_id = message.msg_id
            toSession.update_at = message.create_time
            toSession.unread += 1
            try toSession.save()
        } else {
            let session = Session(msg.to, cid: msg.from, type: 1, msg_id: message.msg_id)
            session.unread += 1
            try session.save()
        }
    }
    
    func groupSession(_ header: apiHeader, _ msg: IM_Message_IMMsgData, message: Message) throws  {
        let members = try Member.makeQuery().filter("cid", msg.to).all()
        for member in members {
            if let session = try Session.makeQuery().filter("user_id", member.user_id).filter("cid", msg.to).first() {
                session.msg_id = message.msg_id
                session.update_at = message.create_time
                session.unread += 1
                try session.save()
            } else {
                let session = Session(msg.from, cid: msg.to, type: 2, msg_id: message.msg_id)
                session.unread += 1
                try session.save()
            }
            //1.header
            var dataOut = DataOutputStream()
            dataOut.writeInt(0)
            dataOut.write(apiHeader(IM_BaseDefine_ServiceID.sidMsg.rawValue,
                                    IM_BaseDefine_MessageCmdID.cidMsgData.rawValue,
                                    0))
            //3.content,leng
            try dataOut.directWriteBytes(NSData(data: msg.serializedData()))
            dataOut.writeDataCount()
            let sendData = Data(referencing: dataOut.data)
            if msg.from != member.user_id { //不给自己发送
                try groupMsgForward(sendData, member)
            }
        }
    }
    
    func msgForward(_ header: apiHeader, _ msg: IM_Message_IMMsgData) throws {
        //1.header
        var dataOut = DataOutputStream()
        dataOut.writeInt(0)
        dataOut.write(apiHeader(IM_BaseDefine_ServiceID.sidMsg.rawValue,
                                IM_BaseDefine_MessageCmdID.cidMsgData.rawValue,
                                0))
        //3.content,leng
        try dataOut.directWriteBytes(NSData(data: msg.serializedData()))
        dataOut.writeDataCount()
        let sendData = Data(referencing: dataOut.data)
        if let ws = connectionUsers[msg.to] {
            try ws.send(sendData.array)
        } else {
            //推送
        }
    }
    func groupMsgForward(_ sendData: Data, _ member: Member) throws {
        if let ws = connectionUsers[member.user_id] {
            try ws.send(sendData.array)
        } else {
            //推送
        }
    }
    
    func msgAck(_ ws: WebSocket, _ header: apiHeader, msg: IM_Message_IMMsgData) throws {
        //1.header
        var dataOut = DataOutputStream()
        dataOut.writeInt(0)
        dataOut.write(apiHeader(IM_BaseDefine_ServiceID.sidMsg.rawValue,
                                IM_BaseDefine_MessageCmdID.cidMsgDataAck.rawValue,
                                header.seq))
        //2.content
        var msgRes = IM_Message_IMMsgDataAck()
        msgRes.errCode = "0"
        msgRes.errMsg = "success"
        msgRes.createTime = "\(msg.createTime)"
        msgRes.msgID = msg.msgID
        //3.leng
        try dataOut.directWriteBytes(NSData(data: msgRes.serializedData()))
        dataOut.writeDataCount()
        let sendData = Data(referencing: dataOut.data)
        try ws.send(sendData.array)
    }

}
