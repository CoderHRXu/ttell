//
//  AboutViewController.swift
//  Ttel
//
//  Created by xuhaoran on 2017/9/28.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController {

    @IBOutlet weak var btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "关于"
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnClick(_ sender: Any) {
        
        
        let url = URL(string:"alipay://platformapi/startapp?saId=10000007")
        
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.openURL(url!)
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
