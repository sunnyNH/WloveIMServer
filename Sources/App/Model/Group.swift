//
//  Group.swift
//  App
//
//  Created by 牛辉 on 2018/1/1.
//

import Vapor
import FluentProvider
import Foundation
import HTTP
import SwiftProtobuf

final class Group: Model {
    let storage = Storage()
    static let entity = "Groups"
    var owner           : String    = ""
    var cid             : String    = ""
    var name            : String    = ""
    var avatar          : String    = ""
    var create_time     : Int       = 0
    init(row: Row) throws {
        owner           = try row.get("owner")
        cid             = try row.get("cid")
        name            = try row.get("name")
        avatar          = try row.get("avatar")
        create_time     = try row.get("create_time")
    }
    func makeRow() throws -> Row {
        return try wildcardRow()
    }
    init (_ user_id: String) {
        self.owner          = user_id
        self.create_time    = Int(Date().timeIntervalSince1970)
        self.cid            = "g_" + "\(user_id)+\(self.create_time)".md5
    }
}
extension Group: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { bar in
            bar.id()
            bar.string("owner")
            bar.string("cid")
            bar.string("name")
            bar.string("avatar")
            bar.int("create_time")
        }
        try database.index("cid", for: self)
        try database.index("owner", for: self)
    }
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
