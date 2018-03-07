//
//  AppDelegate.swift
//  Ttel
//
//  Created by PandaApe on 1/8/17.
//  Copyright © 2017 PandaApe. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

//import JPUSHService
let appKey = "0e660c288a6e368107a160ae"
let channel = "Publish channel"
let isProduction = false


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
  
        // 可以自定义 categories
        JPUSHService.register(
            forRemoteNotificationTypes: UIUserNotificationType.badge.rawValue |
                UIUserNotificationType.sound.rawValue |
                UIUserNotificationType.alert.rawValue,
            categories: nil)
        
        JPUSHService.setup(withOption: launchOptions, appKey: appKey, channel: channel, apsForProduction: isProduction)

        UIApplication.shared.applicationIconBadgeNumber = 0
        
        JPUSHService.setBadge(0)
        
        let homeVC                      = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
        let navVC                       = RootNaviViewController(rootViewController: homeVC)
        self.window                     = UIWindow(frame: UIScreen.main.bounds)
        let slideMenuController         = SlideMenuController(mainViewController: navVC, leftMenuViewController:LeftMenuViewController() )

        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    @objc
    func networkDidReceiveMessage(noti:Notification) {
        print("receive->\(noti)");
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        JPUSHService.registerDeviceToken(deviceToken)
        let data = NSData.init(data: deviceToken)
        let datastr = data.description.replacingOccurrences(of: "<", with: "").replacingOccurrences(of: ">", with: "").replacingOccurrences(of: " ", with: "")
        print("deviceToken为\n" + datastr)
        var jPushTag = String()
        
        #if SIT
            jPushTag = "sit"
        #elseif PRO
            jPushTag = "pro"
        #endif
        
        // 根据环境 设置设备推送tag
        JPUSHService.setTags(Set([jPushTag]), callbackSelector: nil, object: nil)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("受到通知", userInfo)
        JPUSHService.handleRemoteNotification(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("受到通知closer", userInfo)
        JPUSHService.handleRemoteNotification(userInfo)
        
        completionHandler(.newData)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        JPUSHService.setBadge(0)
    }
}

