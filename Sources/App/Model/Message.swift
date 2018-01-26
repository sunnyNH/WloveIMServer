//
//  Message.swift
//  App
//
//  Created by 牛辉 on 2017/12/31.
//

import Vapor
import FluentProvider
import Foundation
import HTTP
import SwiftProtobuf

final class Message: Model {
    let storage = Storage()
    static let entity = "Messages"
    var msg_id          : Int       = 0
    var from            : String    = ""
    var to              : String    = ""
    var type            : String    = ""
    var subtype         : String    = ""
    var msg_data        : String    = ""
    var create_time     : Int       = 0
    init(row: Row) throws {
        msg_id          = try row.get("msg_id")
        from            = try row.get("from")
        to              = try row.get("to")
        type            = try row.get("type")
        subtype         = try row.get("subtype")
        msg_data        = try row.get("msg_data")
        create_time     = try row.get("create_time")
    }
    func makeRow() throws -> Row {
        return try wildcardRow()
    }
    init (_ msg: IM_Message_IMMsgData) {
        from        = msg.from
        to          = msg.to
        type        = msg.type
        subtype     = msg.subtype
        msg_data    = msg.msgData
        create_time = Int(Date().timeIntervalSince1970)
    }
}
extension Message: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { bar in
            bar.id()
            bar.int("msg_id")
            bar.string("from")
            bar.string("to")
            bar.string("type")
            bar.string("subtype")
            bar.string("msg_data")
            bar.int("create_time")
        }
        try database.index("from", for: self)
        try database.index("to", for: self)
        try database.index("create_time", for: self)
    }
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

