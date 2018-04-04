//
//  SettingViewController.swift
//  Ttel
//
//  Created by PandaApe on 19/04/2017.
//  Copyright © 2017 Sunfit. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController {
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackIcon();
        
        // Navi Title
        self.navigationItem.title = "设置"
        
        
    }
    
}
