//
//  GameRoom.swift
//  App
//
//  Created by 牛辉 on 2018/1/1.
//

import Vapor
import FluentProvider
import Foundation
import HTTP
import SwiftProtobuf

final class GameRoom: Model {
    let storage = Storage()
    static let entity = "GameRooms"
    var name            : String    = ""
    //1.五子棋 2.不知道
    var type            : Int       = 0
    var passWord        : String    = ""
    var is_lock         : Bool      = false
    var create_time     : Int       = 0
    init(row: Row) throws {
        name                = try row.get("name")
        type                = try row.get("type")
        passWord            = try row.get("passWord")
        is_lock             = try row.get("is_lock")
        create_time         = try row.get("create_time")
    }
    func makeRow() throws -> Row {
        return try wildcardRow()
    }
    init (_ name:String, _ type: Int, _ passWord: String, _ is_lock: Bool) {
        self.name           = name
        self.type           = type
        self.passWord       = passWord
        self.is_lock        = is_lock
        self.create_time    = Int(Date().timeIntervalSince1970)
    }
}
extension GameRoom {
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("type", type)
        try json.set("name", name)
        try json.set("is_lock", is_lock)
        try json.set("create_time", create_time)
        try json.set("members", memberJson().map{try $0.makeJSON()})
        return json
    }
}
extension GameRoom {
    func memberJson() throws -> [GameMember] {
        let files = try GameMember.makeQuery().filter("gameroom_id", self.id).all()
        return files
    }
}
extension GameRoom: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { bar in
            bar.id()
            bar.string("name")
            bar.string("passWord")
            bar.bool("is_lock")
            bar.int("type")
            bar.int("create_time")
        }
        try database.index("create_time", for: self)
        try database.index("type", for: self)

    }
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
