//
//  ApiService.swift
//  Ttel
//
//  Created by PandaApe on 1/10/17.
//  Copyright © 2017 PandaApe. All rights reserved.
//

import Foundation
import Moya
import RxSwift

enum ApiService {
    
    case ListAllProds       (pageNo:Int, pageSize:Int)
    
    case ListSpecificProd   (prodType:Int, envType:Int, pageNo:Int, pageSize:Int)
    
    case SendEmailToTester  (itemIds:Array<String>, emailAddresses:Array<String>)
    
    case deleteItem         (itemId: String)
}

extension ApiService:TargetType{
    var headers: [String : String]? {
        return nil
    }
    
    
    /// The target's base `URL`.
    var baseURL: URL {
        
        let urlStr = CacheHandler.sharedInstance.baseUrlString + ":" + CacheHandler.sharedInstance.port + "/apiv1/"
        return URL.init(string: urlStr)!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        
        switch self {
            
        case .ListAllProds:
            return "app/listAllProds"
            
        case .ListSpecificProd:
            return "app/listSpecificProd"
         
        case .SendEmailToTester:
            return "app/emailqa"
            
        case .deleteItem:
            return "api/app/delete"
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        
        switch self {
        case .SendEmailToTester:
            return .post
        default:
            return .get
        }
    }
    
    /// The parameters to be incoded in the request.
    var parameters: [String: Any]? {
        
        switch self {
            
            
        case  .ListAllProds(let pageNo,  let pageSize):
            return ["pageNo":pageNo ,"platform":1 , "pageSize" : pageSize]
            
        case .ListSpecificProd(let prodType, let envType, let pageNo, let pageSize):
            
            return ["prodType":prodType, "envType":envType, "platform":1, "pageNo":pageNo, "pageSize":pageSize]
         
        case .SendEmailToTester(let itemIds, let emailAddresses):
            
            return ["itemIds":itemIds,"receivers":emailAddresses]
            
        case .deleteItem(let itemId):
            return ["itemId": itemId]
        }
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        
        return URLEncoding.default
        
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        
        return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        
        return .requestPlain
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
    
}
