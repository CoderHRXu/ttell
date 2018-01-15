//
//  SystemInfo.swift
//  Ttel
//
//  Created by WeiWei on 2017/5/25.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

import UIKit

class SystemInfo: BaseBean {

    /// 设备唯一标识
    var identifier : String!
    /// 平台 iOS/Android/H5
    var platform : String!
    /// 系统+系统版本
    var system : String!
    /// 设备所有者的名称
    var phoneName : String!
    /// 设备的型号
    var model : String!
    /// APP版本号
    var appVer : String!
    /// APP编译版本号
    var buildVer : String!
    
    
    /*************************************** 管它华不华丽 我就是一条分割线 ***************************************/
    
    required init() {}
    
    func getSystemInfo() -> SystemInfo {
        
        let sysInfo = SystemInfo.init();
        
        sysInfo.identifier = UIDevice.current.identifierForVendor?.uuidString;
        sysInfo.platform = "iOS";
        sysInfo.system = String.init(format: "%@ %@", UIDevice.current.systemName,UIDevice.current.systemVersion);
        sysInfo.phoneName = UIDevice.current.name;
        sysInfo.model = UIDevice.current.modelName;
        
        let infoDict = Bundle.main.infoDictionary;
        //"CFBundleDisplayName" 获取App的名称
        sysInfo.appVer = infoDict?["CFBundleShortVersionString"] as! String;
        sysInfo.buildVer = infoDict?["CFBundleVersion"] as! String;
        
        return sysInfo;
    }
}


//MARK: - UIDevice延展
public extension UIDevice {
    
    /// 自定义方法 获取设备型号
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone9,1":                               return "iPhone 7"
        case "iPhone9,2":                               return "iPhone 7 Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
}

