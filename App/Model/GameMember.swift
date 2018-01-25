//
//  GameMember.swift
//  App
//
//  Created by 牛辉 on 2018/1/1.
//

import Vapor
import FluentProvider
import Foundation
import HTTP
import SwiftProtobuf

final class GameMember: Model {
    let storage = Storage()
    static let entity = "GameMembers"
    //1.五子棋 2.不知道
    var user_id         : String    = ""
    var gameroom_id     : Int       = 0
    var create_time     : Int       = 0
    init(row: Row) throws {
        user_id        = try row.get("user_id")
        gameroom_id    = try row.get("gameroom_id")
        create_time    = try row.get("create_time")
    }
    func makeRow() throws -> Row {
        return try wildcardRow()
    }
    init (_ user_id: String, _ gameroom_id: Int) {
        self.user_id           = user_id
        self.gameroom_id       = gameroom_id
        self.create_time       = Int(Date().timeIntervalSince1970)
    }
}
extension GameMember {
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("user_id", user_id)
        try json.set("gameroom_id", gameroom_id)
        try json.set("create_time", create_time)
        return json
    }
}
extension GameMember: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { bar in
            bar.id()
            bar.string("user_id")
            bar.int("gameroom_id")
            bar.int("create_time")
        }
        try database.index("gameroom_id", for: self)
        try database.index("user_id", for: self)
        
    }
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
