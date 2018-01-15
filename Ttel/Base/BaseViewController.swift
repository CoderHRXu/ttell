//
//  BaseViewController.swift
//  Ttel
//
//  Created by PandaApe on 1/8/17.
//  Copyright © 2017 PandaApe. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {

        super.viewDidLoad()
    }

    func setBackIcon (){
        
        let btnItem = UIBarButtonItem.init(image: R.image.navigationBack(), style: UIBarButtonItemStyle.plain, target: self, action: #selector(popToLastVC))
        
        btnItem.tintColor = UIColor.white
        
        btnItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 10)
        
        self.navigationItem.setLeftBarButton(btnItem, animated: true)
    }
    
    @objc func popToLastVC() {
        
        navigationController?.popViewController(animated: true)
    }
    
    // 加入tableview 背景动画
    func setWebBackgroundView(tableView:UITableView) {
        
        let webView = UIWebView.init(frame: self.view.frame)
        
        let path = Bundle.main.path(forResource: "particle", ofType: "html")
        let url = URL.init(fileURLWithPath: path!)
        
        webView.scrollView.isScrollEnabled = false
        
        webView.backgroundColor = UIColor.clear
        webView.isOpaque = false
        
        webView.loadRequest(URLRequest.init(url: url))
        
        tableView.backgroundView = webView
    }
}
