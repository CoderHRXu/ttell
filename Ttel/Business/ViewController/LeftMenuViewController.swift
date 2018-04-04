//
//  LeftMenuViewController.swift
//  Ttel
//
//  Created by xuhaoran on 2017/9/28.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift


protocol LeftMenuDelegate : NSObjectProtocol {
    
    /// 跳转设置帮助
    ///
    /// - Parameter leftMenu: menu
    func leftMenuDidClickGotoHelp(leftMenu : LeftMenuViewController)
    
    /// 跳转设置关于
    ///
    /// - Parameter leftMenu: menu
    func leftMenuDidClickGotoAbout(leftMenu : LeftMenuViewController)
    
    /// 跳转设置页面
    ///
    /// - Parameter leftMenu: menu
    func leftMenuDidClickGotoSetting(leftMenu : LeftMenuViewController)
}



class LeftMenuViewController: BaseViewController {

    // MARK:- property
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var versionlabel: UILabel!
    
    weak var delegate : LeftMenuDelegate?
    
    
    // MARK:- lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- UI
    func setupUI() {
        
        iconView.layer.cornerRadius = 5
        iconView.layer.masksToBounds = true
        let appVer = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        let build  = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
        versionlabel.text = "v\(appVer)"+" (\(build))"
    }

    // MARK:- Actiom
    @IBAction func cellBtnClick(_ btn: UIButton) {
        
        switch btn.tag {
        case 0:
            gotoNotificationManagement()
            break
        case 1:
            gotoHelp()
            break
        case 2:
            gotoAbout()
            break
        default:
            break
        }
        
    }
    
    fileprivate func gotoNotificationManagement(){
        
        /*
        let action = UIAlertAction(title: "我知道了", style: .default) { (action : UIAlertAction) in
            
        }
        let alertVC = UIAlertController(title: "暂未开放", message: "程序猿哥哥正在加紧开发啦~", preferredStyle: .alert)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
         */
        if let delegate = delegate {
            delegate.leftMenuDidClickGotoSetting(leftMenu: self)
        }
        
    }
    
    fileprivate func gotoHelp(){

//        self.navigationController?.pushViewController(HelpViewController(), animated: true)
        if let delegate = delegate {
            delegate.leftMenuDidClickGotoHelp(leftMenu: self)
        }
    }
    
    fileprivate func gotoAbout(){
        
        if let delegate = delegate {
            delegate.leftMenuDidClickGotoAbout(leftMenu: self)
        }
    }
}
