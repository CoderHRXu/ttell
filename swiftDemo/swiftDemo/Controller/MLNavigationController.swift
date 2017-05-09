//
//  MLViewController.swift
//  swiftDemo
//
//  Created by xuhaoran on 2017/5/4.
//  Copyright © 2017年 SunFit. All rights reserved.
//

import UIKit
import Format

enum NavStyle : Int {
    case deafult    =   0
    case blue       =   1
    case white      =   2
}

class MLNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNaviStye(style: .blue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


extension UINavigationController{

    func setNaviStye(style : NavStyle){
    
        switch style {
        case .deafult:
            print("导航条默认")
            
        case .blue:
            print("导航栏蓝色")
            self.setNaviStyleBlue()
            
        case .white:
            print("导航条白色")
        }
    }
    
    
    /// 设置导航条蓝色
    private func setNaviStyleBlue() {
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        navigationBar.isTranslucent         =   false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage           = UIImage()
        navigationBar.barTintColor          = ColorFormatter().format("46BBFF")
        navigationBar.titleTextAttributes   = [NSForegroundColorAttributeName:UIColor.white]
        

    }


    
    
}
