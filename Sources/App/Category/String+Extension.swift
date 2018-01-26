//
//  String(md5).swift
//  NHServer
//
//  Created by niuhui on 2017/5/10.
//
//

import Crypto
import Vapor

extension String {
    
    var md5 : String {
        do {
            let byes   = self.makeBytes()
            let result = try Hash.make(.md5, byes)
            return result.hexString
        } catch {
            return ""
        }
    }
}
