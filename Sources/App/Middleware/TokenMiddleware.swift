//
//  TokenMiddleware.swift
//  NHServer
//
//  Created by niuhui on 2017/5/9.
//
//

import Vapor
import HTTP
import Foundation


final class TokenMiddleware: Middleware {
    
    func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        guard let user_id = request.data["user_id"]?.string else{
            return try JSON([code: 1,msg : "未登录"]).makeResponse()
        }
        if connectionUsers[user_id] == nil {
            return try JSON([code: 1,msg : "未连接游戏服务器"]).makeResponse()
        }
        return try next.respond(to: request)
    }
}
