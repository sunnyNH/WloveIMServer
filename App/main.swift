
import SwiftProtobuf
import Foundation
import Vapor

let config = try Config()
try config.setup()
let drop = try Droplet(config)
// 基础api
let api   = drop.grouped("api")
let v1    = api.grouped("v1")
let token = v1.grouped(TokenMiddleware())

//http业务
registeredRoute()

// websocket
drop.socket("socket") {(req, ws) in
    print(Int(bitPattern: Unmanaged.passUnretained(ws).toOpaque()))
    print("New WebSocket connected: \(ws.hashValue)")
    background {
        while ws.state == .open {
            drop.console.wait(seconds: 20) // every 10 seconds
            if let _ = connections[ws] {
                if ws.state == .open {
                    print("发送ping")
                    try? ws.ping()
                }
            } else {
                if ws.state == .open {
                    print("身份没有验证")
                    try?  ws.close()
                }
            }
        }
    }
    ws.onBinary = { ws ,data in
        serverRoute(ws, data)
    }
    ws.onPing = { ws ,_ in
        print("ping")
    }
    ws.onPong = { ws ,_ in
        print("pong")
    }
    ws.onClose = { ws, code, reason, clean in
        print("Closed.\(ws.hashValue)")
        if let user_id = connections[ws] {
            connectionUsers[user_id] = nil
            try closed(user_id)
        }
        connections[ws] = nil
    }
}
try drop.run()

