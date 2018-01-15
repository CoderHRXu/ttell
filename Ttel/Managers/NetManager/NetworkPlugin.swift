//
//  LoggerPlugin.swift
//  Powerful
//
//  Created by PandaApe on 5/25/17.
//  Copyright © 2017 Sunfit. All rights reserved.
//

import Foundation
import Moya
import Result

class LoggerPlugin: PluginType {
    
    func willSend(_ request: RequestType, target: TargetType) {
        
        guard let req = request.request  else {
            return
        }
        
        print("\(req.httpMethod ?? ""): \( req.url?.absoluteString ?? "")")
        print("header: \(req.allHTTPHeaderFields?.description ?? "")")
        print("parm: \( req.httpBody?.description ?? "")")
        
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        
        print("api return: \(target)")
        
        switch result {
        case let .success(res):
            
            let jsStr : String = try! res.mapString()

            print(jsStr)
            
        case let .failure(err):
            print(err)
            
        }
        
    }
}
