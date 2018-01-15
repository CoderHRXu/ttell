//
//  AppItem.swift
//  Ttel
//
//  Created by PandaApe on 2/6/17.
//  Copyright © 2017 PandaApe. All rights reserved.
//

import Foundation


class AppItem: BaseBean {
    
    var appIdentifier : String!
    var buildVersion : String!
    var changeLog : String?
    var createdDate : String!
    var displayName : String!
    var downloadUrl : String!
    var envType : Int!
    var fileSize : String!
    var iconUrl : String!
    var itemId : String!
    var platform : Int!
    var prodType : Int!
    var updatedDate : String!
    var version : String!
    
    required init() {}
    
}


