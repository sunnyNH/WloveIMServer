//
//  Session.swift
//  App
//
//  Created by 牛辉 on 2017/12/31.
//

import Vapor
import FluentProvider
import Foundation
import HTTP
import SwiftProtobuf

final class Session: Model {
    let storage = Storage()
    static let entity = "Sessions"
    var msg_id          : Int       = 0
    var cid             : String    = ""
    var user_id         : String    = ""
    // 1.单聊   2.群聊
    var type            : Int       = 0
    var update_at       : Int       = 0
    var unread          : Int       = 0
    init(row: Row) throws {
        msg_id          = try row.get("msg_id")
        cid             = try row.get("cid")
        user_id         = try row.get("user_id")
        type            = try row.get("type")
        update_at       = try row.get("update_at")
        unread          = try row.get("unread")
    }
    func makeRow() throws -> Row {
        return try wildcardRow()
    }
    init (_ user_id: String, cid: String, type: Int , msg_id: Int) {
        self.msg_id = msg_id
        self.type = type
        self.cid = cid
        self.user_id = user_id
    }
}
extension Session: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { bar in
            bar.id()
            bar.int("msg_id")
            bar.string("cid")
            bar.string("user_id")
            bar.int("type")
            bar.int("update_at")
            bar.int("unread")
        }
        try database.index("cid", for: self)
        try database.index("user_id", for: self)
        try database.index("unread", for: self)
    }
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

