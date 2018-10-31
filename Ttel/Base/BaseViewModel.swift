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
        
        let newEndpointClosure = { (target: T) -> Endpoint in
            
            let URL = target.baseURL.appendingPathComponent(target.path).absoluteString;
            
            let endpoint = Endpoint.init(url: URL, sampleResponseClosure: { () -> EndpointSampleResponse in
                .networkResponse(200, target.sampleData)
            }, method: target.method, task: target.task, httpHeaderFields: target.headers)
            
            
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
        
        let newProvider = MoyaProvider<T>(endpointClosure: newEndpointClosure, plugins:[PluginEx(),LoggerPlugin()]);
        
        return Observable<Response>.create { (observer) -> Disposable in
            
            let cancellableToken = newProvider.request(target, completion: { (result) in
                switch result {
                case let .success(response):
                    observer.onNext(response)
                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(error)
                }
            })
            
            return Disposables.create {
                cancellableToken.cancel()
            }
            }.parseError()
    }
}

