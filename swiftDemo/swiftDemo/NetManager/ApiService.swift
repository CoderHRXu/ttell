//
//  ApiService.swift
//  swiftDemo
//
//  Created by xuhaoran on 2017/5/8.
//  Copyright © 2017年 SunFit. All rights reserved.
//

import Foundation
import Moya
import RxSwift

let apiProvider = RxMoyaProvider<ApiServiceUrl>()



enum ApiServiceUrl {
    
    case allAppListUrl      (platform:Int , pageNo  : Int , pageSize:Int)
    
    case specificAppList    (prodType:Int , envType : Int , platform: Int , pageNo : Int , pageSize:Int)
}


extension ApiServiceUrl : TargetType{


    var baseURL : URL {
    
        return URL(string: "https://172.16.88.230:8383/apiv1/")!
    }
    
    var path :String {
        
        switch self {
            
        case .allAppListUrl:
            return "app/listAllProds"
            
        case .specificAppList:
            return "app/listSpecificProd"
       
        }
    }
    
    
    var  method : Moya.Method {
    
        return .get
    }
    
    
    var parameters : [String : Any]? {
    
        switch self {
            
        case .allAppListUrl(platform: let platform, pageNo: let pageNo, pageSize: let pageSize):
            
            return ["platform" : platform , "pageNo": pageNo , "pageSize" : pageSize ]
            
        case .specificAppList( let prodType,  let envType,  let platform, let pageNo,  let pageSize):
            
            return ["prodType" : prodType , "envType" : envType , "platform" : platform , "pageNo" : pageNo , "pageSize" : pageSize]
        }
    }
    
    
    
    var parameterEncoding : ParameterEncoding {
    
        return URLEncoding.default
    }
    
    
    var sampleData : Data{
    
        return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
    }
    
    

    var task : Task {
    
        return .request
    }
    

    var  validate : Bool {
    
        return false
    }
    
    
}
