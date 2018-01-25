//
//  ServerProtocol.swift
//  App
//
//  Created by 牛辉 on 2017/12/31.
//
import Foundation
import Vapor
protocol ServerProrocol {
    func registered()
    func route(_ header: apiHeader,_ ws: WebSocket, _ contentData: Data)
}
