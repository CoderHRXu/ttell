//
//  Observable+HandJSON.swift
//  Ttel
//
//  Created by PandaApe on 2017/5/23.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import HandyJSON

extension ObservableType where E == Response {
    public func mapModelObject<T: HandyJSON>(_ type: T.Type, designatedPath:String = "data") -> Observable<T> {
        return flatMap { response -> Observable<T> in
            
            print("~~~~")
            
            guard let mapStr = try? response.mapString(), let obj = T.deserialize(from: mapStr, designatedPath: designatedPath) else{
                
                
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            return Observable.just(obj)
        }
    }
    
    public func mapModelArray<T: HandyJSON>(_ type: T.Type, designatedPath:String = "data") -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            
            
            guard let mapStr = try? response.mapString(), let obj = [T].deserialize(from: mapStr, designatedPath: designatedPath) as? [T] else{
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            return Observable.just(obj)
        }
    }
    
//    public func checkStatusCode<T: HandyJSON>(_ type:T.Type ,designatedPath:String = "data") -> Observable<[T]> {
//        return flatMap{ Response -> Observable<[T]> in
//            
//            
//        }
//        
//    }
}

enum RxSwiftMoyaError: String {
    case ParseJSONError
    case OtherError
}

extension RxSwiftMoyaError: Swift.Error {}
