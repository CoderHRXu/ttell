//
//  RootNaviViewController.swift
//  Ttel
//
//  Created by PandaApe on 1/8/17.
//  Copyright © 2017 PandaApe. All rights reserved.
//

import UIKit
import Format

enum NavStyle : Int {
    case deafult    = 0
    case blue       = 1
    case white      = 2
}

extension UINavigationController {
    
    /// nav extension
    func setNavStyle(style:NavStyle) {
        
        switch style {
            
            case NavStyle.deafult:
                print("nav style deafult")
                self.setNavStyleBlue()
            
            case NavStyle.blue:
                print("nav style blue")
                
            case NavStyle.white:
                print("nav style white")
        }
    }
    
    private func setNavStyleBlue(){
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        self.navigationBar.isTranslucent   = false
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage     = UIImage()
        self.navigationBar.barTintColor    = ColorFormatter().format("46BBFF")
        self.navigationBar.tintColor       = UIColor.white
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
    }
}

class RootNaviViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNavStyle(style: NavStyle.deafult)
    }
}
