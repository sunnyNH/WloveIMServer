//
//  Member.swift
//  App
//
//  Created by 牛辉 on 2018/1/1.
//

import Vapor
import FluentProvider
import Foundation
import HTTP
import SwiftProtobuf

final class Member: Model {
    let storage = Storage()
    static let entity = "Members"
    var user_id         : String    = ""
    var cid             : String    = ""
    var create_time     : Int       = 0
    init(row: Row) throws {
        user_id         = try row.get("user_id")
        cid             = try row.get("cid")
        create_time     = try row.get("create_time")
    }
    func makeRow() throws -> Row {
        return try wildcardRow()
    }
    init (_ user_id: String, _ group_id: Int, _ cid: String) {
        self.user_id        = user_id
        self.create_time    = Int(Date().timeIntervalSince1970)
        self.cid            = cid
    }
}
extension Member: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { bar in
            bar.id()
            bar.string("cid")
            bar.string("user_id")
            bar.int("create_time")
            bar.foreignKey("cid", references: "cid", on: Group.self)
        }
        try database.index("cid", for: self)
        try database.index("user_id", for: self)
    }
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
