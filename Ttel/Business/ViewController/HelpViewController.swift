//
//  HelpViewController.swift
//  Ttel
//
//  Created by WeiWei on 2017/9/7.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

import UIKit

class HelpViewController: BaseViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackIcon();
        
        // Navi Title
        self.navigationItem.title = "帮助"
        
        // Right navi btn
        let barItem = UIBarButtonItem(title: "安装证书", style: UIBarButtonItemStyle.plain, target: self, action: #selector(installCerBtnClicked))
        self.navigationItem.rightBarButtonItem = barItem;
        
        // Load tutorial image
        self.webView.loadRequest(URLRequest(url: URL(fileURLWithPath: Bundle.main.path(forResource: "CerInstallation", ofType: "jpg")!)))
        
    }
    
    func installCerBtnClicked(){
        
        let urlStr = CacheHandler.sharedInstance.baseUrlString + ":" + CacheHandler.sharedInstance.port + "/cer/pubCer/selfSigned_pubCA.cer"
        let url = URL.init(string: urlStr)!
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
//        #if DEV
//            UIApplication.shared.openURL(URL(string: "https://10.0.3.223:8873/cer/pubCer/selfSigned_pubCA.cer")!)
//
//        #endif
//
//        #if PRO
//            UIApplication.shared.openURL(URL(string: "https://10.0.2.17:8874/cer/pubCer/selfSigned_pubCA.cer")!)
//
//        #endif
    }
}
