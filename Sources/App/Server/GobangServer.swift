//
//  GameServer.swift
//  App
//
//  Created by 牛辉 on 2018/1/1.
//

import Foundation
import Vapor
//五子棋
struct GobangServer: ServerProrocol  {
    func registered() {
        let key = "\(IM_BaseDefine_ServiceID.sidGame.rawValue)-\(IM_BaseDefine_GameCmdID.cidGobangData.rawValue)"
        servers[key] = self
    }
    func route(_ header: apiHeader, _ ws: WebSocket, _ contentData: Data) {
        do {
            let goBang = try G_Gobang_GobangData(serializedData: contentData)
            //1.转发
            try msgForward(header, goBang)
            //2.ack
            try msgAck(ws, header, goBang: goBang)
        } catch {
            print(error)
        }
    }
    
    func msgForward(_ header: apiHeader, _ goBang: G_Gobang_GobangData) throws {
        //1.header
        var dataOut = DataOutputStream()
        dataOut.writeInt(0)
        dataOut.write(apiHeader(IM_BaseDefine_ServiceID.sidGame.rawValue,
                                IM_BaseDefine_GameCmdID.cidGobangData.rawValue,
                                0))
        //3.content,leng
        try dataOut.directWriteBytes(NSData(data: goBang.serializedData()))
        dataOut.writeDataCount()
        let sendData = Data(referencing: dataOut.data)
        if let ws = connectionUsers[goBang.to] {
            try ws.send(sendData.array)
        }
    }
    func msgAck(_ ws: WebSocket, _ header: apiHeader, goBang: G_Gobang_GobangData) throws {
        //1.header
        var dataOut = DataOutputStream()
        dataOut.writeInt(0)
        dataOut.write(apiHeader(IM_BaseDefine_ServiceID.sidGame.rawValue,
                                IM_BaseDefine_GameCmdID.cidGobangAck.rawValue,
                                header.seq))
        //2.content
        var msgRes = G_Gobang_GobangAck()
        msgRes.errCode = "0"
        msgRes.errMsg = "success"
        //3.leng
        try dataOut.directWriteBytes(NSData(data: msgRes.serializedData()))
        dataOut.writeDataCount()
        let sendData = Data(referencing: dataOut.data)
        try ws.send(sendData.array)
    }
}

func closed(_ user_id: String) throws {
    if let members = try? GameMember.makeQuery().filter("user_id", user_id).all() {
        for member in members {
            try member.delete()
            let roomMembers = try GameMember.makeQuery().filter("gameroom_id", member.gameroom_id).all()
            if roomMembers.count == 0 {
                let room = try GameRoom.makeQuery().filter("id", member.gameroom_id).first()
                try room?.delete()
            } else {
                for memb in roomMembers {
                    try msgDisConnect(room_id: memb.gameroom_id, user_id: memb.user_id)
                }
            }
        }
    }
}
func msgDisConnect(room_id: Int,user_id: String)throws {
    //1.header
    var dataOut = DataOutputStream()
    dataOut.writeInt(0)
    dataOut.write(apiHeader(IM_BaseDefine_ServiceID.sidGame.rawValue,
                            IM_BaseDefine_GameCmdID.cidGobangData.rawValue,
                            0))
    //gobang
    var goBang = G_Gobang_GobangData()
    goBang.type = 8
    goBang.subtype = 0
    goBang.from = "sunny_sunny"
    goBang.roomID = UInt32(room_id)
    goBang.to   = user_id
    goBang.x  = 0
    goBang.y  = 0
    goBang.msg = ""
    //3.content,leng
    try dataOut.directWriteBytes(NSData(data: goBang.serializedData()))
    dataOut.writeDataCount()
    let sendData = Data(referencing: dataOut.data)
    if let ws = connectionUsers[user_id] {
        try ws.send(sendData.array)
    }
}
