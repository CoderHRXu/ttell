//
//  CacheHandler.swift
//  Ttel
//
//  Created by PandaApe on 2/6/17.
//  Copyright © 2017 PandaApe. All rights reserved.
//

import Foundation





class CacheHandler {
    
    

    static let sharedInstance = CacheHandler()
    
    var baseUrlString: String {
        get{
            let urlStr     = UserDefaults.standard.value(forKey: "baseUrl") as? String
            return urlStr ?? "https://10.0.3.223"
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "baseUrl")
            UserDefaults.standard.synchronize()
        }
    }
    
    var port: String {
        get{
            let port     = UserDefaults.standard.value(forKey: "port") as? String
            return port ?? "8863"
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "port")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    fileprivate init() {}
    
    
    
}
