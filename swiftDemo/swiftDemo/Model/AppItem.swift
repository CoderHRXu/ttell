//
//  AppItem.swift
//  swiftDemo
//
//  Created by xuhaoran on 2017/5/8.
//  Copyright © 2017年 SunFit. All rights reserved.
//

import Foundation



class AppItem: BaseBean {
    
    var appIdentifier : String!
    var buildVersion : String!
    var changeLog : String?
    var createdDate : Int!
    var displayName : String!
    var downloadUrl : String!
    var envType : Int!
    var fileSize : String!
    var iconUrl : String!
    var itemId : String!
    var platform : Int!
    var prodType : Int!
    var updatedDate : Int64!
    var version : String!
    
    required init() {}
    
}


