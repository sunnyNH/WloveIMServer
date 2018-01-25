//
//  AudioServer.swift
//  App
//
//  Created by 牛辉 on 2018/1/10.
//

import Foundation
import Vapor

struct AudioServer: ServerProrocol  {
    func registered() {
        let key = "\(IM_BaseDefine_ServiceID.sidAudio.rawValue)-\(IM_BaseDefine_AudioCmdID.cidAudioData.rawValue)"
        servers[key] = self
    }
    
    func route(_ header: apiHeader, _ ws: WebSocket, _ contentData: Data) {
        do {
            let audio = try IM_Audio_IMAudioData(serializedData: contentData)
            //1.转发
            try msgForward(header, audio)
            if audio.type != 99 {
                //2.ack
                try msgAck(ws, header, audio: audio)
            }
        } catch {
            print(error)
        }

    }
    func msgForward(_ header: apiHeader, _ audio: IM_Audio_IMAudioData) throws {
        //1.header
        var dataOut = DataOutputStream()
        dataOut.writeInt(0)
        dataOut.write(apiHeader(IM_BaseDefine_ServiceID.sidAudio.rawValue,
                                IM_BaseDefine_AudioCmdID.cidAudioData.rawValue,
                                0))
        //3.content,leng
        try dataOut.directWriteBytes(NSData(data: audio.serializedData()))
        dataOut.writeDataCount()
        let sendData = Data(referencing: dataOut.data)
        if let ws = connectionUsers[audio.to] {
            try ws.send(sendData.array)
        }
    }
    func msgAck(_ ws: WebSocket, _ header: apiHeader, audio: IM_Audio_IMAudioData) throws {
        //1.header
        var dataOut = DataOutputStream()
        dataOut.writeInt(0)
        dataOut.write(apiHeader(IM_BaseDefine_ServiceID.sidAudio.rawValue,
                                IM_BaseDefine_AudioCmdID.cidAudioAck.rawValue,
                                header.seq))
        //2.content
        var msgRes = IM_Audio_IMAudioAck()
        msgRes.errCode = "0"
        msgRes.errMsg = "success"
        //3.leng
        try dataOut.directWriteBytes(NSData(data: msgRes.serializedData()))
        dataOut.writeDataCount()
        let sendData = Data(referencing: dataOut.data)
        try ws.send(sendData.array)
    }
}
