//
//  BaseViewController.swift
//  swiftDemo
//
//  Created by xuhaoran on 2017/5/4.
//  Copyright © 2017年 SunFit. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK:- UI
   
    /// 设置导航条左键头返回
    func setNaviBackBtn() {
        
        let btnItem = UIBarButtonItem.init(image: UIImage.init(named: "navigationBack"), style: .plain, target: self, action: #selector(popToLastVC))
        btnItem.tintColor = UIColor.white
        btnItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 10)
        navigationItem.setLeftBarButton(btnItem, animated: true)
        
    }
    
    @objc func popToLastVC (){
    
        navigationController?.popViewController(animated: true)
    }
}
