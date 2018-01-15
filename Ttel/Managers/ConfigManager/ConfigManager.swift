//
//  ConfigManager.swift
//  Ttel
//
//  Created by PandaApe on 2017/5/23.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

import UIKit

class ConfigManager {

    static var baseURL:URL {
        
        get{
            
            #if DEV
                return URL(string: "http://172.16.88.230:8863/apiv1/")!
                
            #else
            
                return URL(string: "https://172.16.88.230:8874/apiv1/")!
                
            #endif
        }
        
    }
    
    let screenWidth     = UIScreen.main.bounds.width
    let screenHeight    = UIScreen.main.bounds.height
}
