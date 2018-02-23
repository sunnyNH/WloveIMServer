//
//  LoginController.swift
//  App
//
//  Created by 牛辉 on 2017/12/31.
//

import Foundation
import Vapor
struct LoginServer: ServerProrocol {
    //业务服务器内部地址 校验token信息
    static let loginUrl: String = "http://0.0.0.0:8000/api/v1/inner/accesstoken"
    func registered() {
        let key = "\(IM_BaseDefine_ServiceID.sidLogin.rawValue)-\(IM_BaseDefine_LoginCmdID.cidLoginReqUserlogin.rawValue)"
        servers[key] = self
    }
    func route(_ header: apiHeader, _ ws: WebSocket, _ contentData: Data) {
        do {
            let loginReq = try IM_Login_IMLoginReq(serializedData: contentData)
            let req = try drop.client.post(LoginServer.loginUrl, query: ["token":loginReq.accessToken])
            print(req)
            if req.status.hashValue == 200,let user_id = req.json?["user_id"]?.string {
                connections[ws] = user_id
                connectionUsers[user_id] = ws
                //ws返回res
                //1.header
                var dataOut = DataOutputStream()
                dataOut.writeInt(0)
                dataOut.write(apiHeader(IM_BaseDefine_ServiceID.sidLogin.rawValue,
                                        IM_BaseDefine_LoginCmdID.cidLoginResUserlogin.rawValue,
                                        header.seq))
                //2.content
                var loginRes = IM_Login_IMLoginRes()
                loginRes.errCode = .ok
                loginRes.errMsg = "success"
                loginRes.serverTime = UInt32(Date().timeIntervalSince1970)
                //3.leng
                try dataOut.directWriteBytes(NSData(data: loginRes.serializedData()))
                dataOut.writeDataCount()
                let sendData = Data(referencing: dataOut.data)
                try ws.send(sendData.array)
            } else {
                //ws返回res
                //1.header
                var dataOut = DataOutputStream()
                dataOut.writeInt(0)
                dataOut.write(apiHeader(IM_BaseDefine_ServiceID.sidLogin.rawValue,
                                        IM_BaseDefine_LoginCmdID.cidLoginResUserlogin.rawValue,
                                        header.seq))
                //2.content
                var loginRes = IM_Login_IMLoginRes()
                loginRes.errCode = .refused
                loginRes.errMsg = "校验失败"
                loginRes.serverTime = UInt32(Date().timeIntervalSince1970)
                //3.leng
                try dataOut.directWriteBytes(NSData(data: loginRes.serializedData()))
                dataOut.writeDataCount()
                let sendData = Data(referencing: dataOut.data)
                try ws.send(sendData.array)
            }
        } catch  {
            print(error)
        }
    }
    
}
