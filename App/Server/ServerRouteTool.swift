//
//  ServerRouteTool.swift
//  App
//
//  Created by 牛辉 on 2017/12/31.
//



import SwiftProtobuf
import Foundation
import Vapor

var connections:        [WebSocket : String]       = [:]
var connectionUsers:    [String    : WebSocket]    = [:]
/// 定义元组 包头主要信息 区分业务
typealias apiHeader = (sid: Int,cid: Int,seq: Int)

var servers:            [String    : ServerProrocol] = [:]

func serverRoute(_ ws: WebSocket, _ data: Bytes) {
    
    let data = Data(bytes: data)
    if data.count < 16 {
        return
    }
    let headerData = data[0...15]
    var inputData = DataInputStream(NSData(data: headerData))
    let dataLen = inputData.readInt()
    if Int(dataLen) > data.count {
        return
    }
    _               = inputData.readShort()
    _               = inputData.readShort()
    let serviceId   = inputData.readShort()
    let commandId   = inputData.readShort()
    let reserved    = inputData.readShort()
    _               = inputData.readShort()
    print("收到信息 服务id=\(serviceId) 命令id=\(commandId) 序列号=\(reserved)")
    let key = "\(serviceId)-\(commandId)"
    if let server = servers[key] {
        let header = apiHeader(Int(serviceId),Int(commandId),Int(reserved))
        let contentData = data[16..<data.count]
        server.route(header, ws, contentData)
    }
    
    
}
