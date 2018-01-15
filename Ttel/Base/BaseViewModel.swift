//
//  BaseViewModel.swift
//  Ttel
//
//  Created by PandaApe on 2017/5/23.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import PromiseKit

class PluginEx: PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        print("header->\(String(describing: request.request?.allHTTPHeaderFields))")
    }
}



class BaseViewModel {
    
    internal let disposeBag = DisposeBag()
    
    func sendRequest<T:TargetType>(target:T) -> Observable<Response>{
        
        let newEndpointClosure = { (target: T) -> Endpoint<T> in
            
            let URL = target.baseURL.appendingPathComponent(target.path).absoluteString;
            
            let endpoint = Endpoint<T>(url: URL,
                                       sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                                       method: target.method,
                                       parameters: target.parameters);
            
            let sysInfo = SystemInfo().getSystemInfo();
            
            let newEndPoint = endpoint.adding(newHTTPHeaderFields: ["X-ML-Identifier" : sysInfo.identifier])
                            .adding(newHTTPHeaderFields: ["X-ML-Platform"   : sysInfo.platform])
                            .adding(newHTTPHeaderFields: ["X-ML-System"     : sysInfo.system])
                            .adding(newHTTPHeaderFields: ["X-ML-Name"       : sysInfo.phoneName])
                            .adding(newHTTPHeaderFields: ["X-ML-Model"      : sysInfo.model])
                            .adding(newHTTPHeaderFields: ["X-ML-AppVer"     : sysInfo.appVer])
                            .adding(newHTTPHeaderFields: ["X-ML-buildVer"   : sysInfo.buildVer]);
            
            return newEndPoint;
        }
        
        let newProvider = RxMoyaProvider<T>(endpointClosure: newEndpointClosure, plugins:[PluginEx(),LoggerPlugin()]);
        
        return newProvider.request(target).filterSuccessfulStatusCodes()

    }
}

