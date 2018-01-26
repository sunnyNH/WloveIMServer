//
//  GameController.swift
//  App
//
//  Created by 牛辉 on 2018/1/1.
//

import Foundation
import Vapor
import HTTP

struct GobangController {

    func registeredRouting() {
        v1.get("game","gobang", handler: self.getGoBangs)
        v1.get("game","gobang","detail", handler: self.getGoBangDetail)
        token.post("game","gobang", handler: self.createGoBang)
        v1.post("game","gobang","quit", handler: self.quitGoBang)
        token.post("game","gobang","add", handler: self.addGoBang)
    }
    func getGoBangs(_ request: Request) throws -> ResponseRepresentable {

        var rooms:[GameRoom] = []
        let roomQuery = try GameRoom.makeQuery().filter("type", 1).sort("create_time", .descending)
        if var page = request.data["pagenum"]?.int  {
            if page == 0 {
                page = 1
            }
            rooms = try roomQuery.limit(20, offset: 20*(page - 1)).all()
        } else {
            rooms = try roomQuery.limit(20, offset: 0).all()
        }
        return try JSON(node: [
            "rooms": rooms.map{try $0.makeJSON()}
            ]).success()
    }
    func getGoBangDetail(_ request: Request) throws -> ResponseRepresentable {
        
        guard let room_id = request.data["room_id"]?.int else{
            return try JSON(node: [code: 1,msg : "缺少room_id"])
        }
        guard let room = try GameRoom.makeQuery().filter("id", room_id).first() else{
            return try JSON(node: [code: 1,msg : "房间不存在"])
        }
        return try JSON(node: [
            "room": room.makeJSON()
            ]).success()
    }
    func createGoBang(_ request: Request) throws -> ResponseRepresentable {
        guard let user_id = request.data["user_id"]?.string else{
            return try JSON(node: [code: 1,msg : "缺少参数"])
        }
        guard let type = request.data["type"]?.int else{
            return try JSON(node: [code: 1,msg : "缺少type"])
        }
        let room = GameRoom("", type, "", false)
        if let name = request.data["name"]?.string {
            room.name = name
        }
        if let passWord = request.data["passWord"]?.string {
            room.passWord = passWord
        }
        if let is_lock = request.data["is_lock"]?.bool {
            room.is_lock = is_lock;
        }
        try room.save()
        let member = GameMember(user_id, room.id!.int!)
        try member.save()
        return try JSON(node: [code: 0,msg: "success", "id": room.id?.int ?? 0,
                               ])
    }
    func quitGoBang(_ request: Request) throws -> ResponseRepresentable {
        guard let user_id = request.data["user_id"]?.string else{
            return try JSON(node: [code: 1,msg : "缺少参数"])
        }
        guard let room_id = request.data["room_id"]?.int else{
            return try JSON(node: [code: 1,msg : "缺少room_id"])
        }
        if let member = try GameMember.makeQuery().filter("user_id", user_id).filter("gameroom_id", room_id).first() {
            try member.delete()
        }
        let count = try GameMember.makeQuery().filter("gameroom_id", room_id).count()
        if count == 0 {
            let room = try GameRoom.makeQuery().filter("id", room_id).first()
            try room?.delete()
        }
        return try JSON(node: [code: 0,msg: "success"])
    }
    func addGoBang(_ request: Request) throws -> ResponseRepresentable {
        guard let user_id = request.data["user_id"]?.string else{
            return try JSON(node: [code: 1,msg : "缺少参数"])
        }
        guard let room_id = request.data["room_id"]?.int else{
            return try JSON(node: [code: 1,msg : "缺少room_id"])
        }
        guard let room = try GameRoom.makeQuery().filter("id", room_id).first() else{
            return try JSON(node: [code: 1,msg : "房间不存在"])
        }
        if let _ = try GameMember.makeQuery().filter("user_id", user_id).filter("gameroom_id", room_id).first() {
            return try JSON(node: [code: 1,msg : "已经加入了房间"])
        }
        if room.is_lock {
            guard let passWord = request.data["passWord"]?.string else{
                return try JSON(node: [code: 1,msg : "缺少密码"])
            }
            if passWord != room.passWord {
                return try JSON(node: [code: 1,msg : "请输入正确的房间密码"])
            }
        }
        let member = GameMember(user_id, room_id)
        try member.save()
        return try JSON(node: [code: 0,msg: "success"])
    }
}
