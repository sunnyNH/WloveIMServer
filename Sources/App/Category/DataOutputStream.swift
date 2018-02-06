//
//  DataOutputStream.swift
//
//  Created by 牛辉 on 2017/4/3.
//  Copyright © 2017年 Niu. All rights reserved.
//
import Foundation
import Vapor
struct DataOutputStream {
    
    var data: NSMutableData
    var lenght: Int = 0
    init() {
        self.data = NSMutableData()
        self.lenght = 0
    }
    mutating func writeShort(_ v: Int32) {
        var ch = [UInt8](repeating: 0, count: 2)
        ch[0] = UInt8((v & 0x0ff00)>>8)
        ch[1] = UInt8( v & 0x0ff  )
        data.append(ch, length: 2)
        self.lenght = self.lenght + 2
    }
    mutating func directWriteBytes(_ data: NSData) {
        let len = data.length
        self.data.append(Data(bytes: data.bytes, count: len))
        self.lenght = self.lenght + len
    }
    func writeDataCount() {
        var ch = [UInt8](repeating: 0, count: 4)
        for i in 0..<4 {
            ch[i] = (UInt8((self.lenght >> ((3 - i)*8)) & 0x0ff))
        }
        data.replaceBytes(in: NSMakeRange(0, 4), withBytes: ch, length: 4)
    }
    mutating func writeInt(_ v: Int32) {
        var ch = [UInt8](repeating: 0, count: 4)
        for i in 0..<4 {
            ch[i] = (UInt8(UInt8((v >> ((3 - i)*8)) & 0x0ff)))
        }
        self.data.append(ch, length: 4)
        lenght = lenght + 4;
    }
}
extension DataOutputStream {
    mutating func write(_ header: apiHeader) {
        writeShort(1)
        writeShort(0)
        writeShort(Int32(header.sid))
        writeShort(Int32(header.cid))
        writeShort(Int32(header.seq))
        writeShort(1)
    }
}
