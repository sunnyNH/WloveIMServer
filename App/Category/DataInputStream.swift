//
//  DataInputStream.swift
//
//  Created by 牛辉 on 2017/4/2.
//  Copyright © 2017年 Niu. All rights reserved.
//

import Foundation

struct DataInputStream {
    var data: NSData
    var length: Int = 0
    
    init(_ Data : NSData) {
        self.data = Data
        self.length = 0
    }
    public mutating func readInt() -> Int32 {
        let ch1 = read()
        let ch2 = read()
        let ch3 = read()
        let ch4 = read()
        if (ch1 | ch2 | ch3 | ch4) < 0 {
            return 0
        }
        return ((ch1 << 24) + (ch2 << 16) + (ch3 << 8) + (ch4 << 0))
    }
    public mutating func readShort() -> Int16 {
        let ch1 = read()
        let ch2 = read()
        if (ch1 | ch2) < 0 {

        }
        return Int16((ch1 << 8) + (ch2 << 0))
    }
    private mutating  func read() -> Int32  {
        
        var v : Int8 = 0
        data.getBytes(&v, range: NSRange(location: length, length: 1))
        length += 1
        return (Int32(v)&0x0ff)
    }
}
