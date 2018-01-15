//
//  ContainerViewController.swift
//  Ttel
//
//  Created by WeiWei on 2017/9/7.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class ContainerViewController: SlideMenuController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addLeftBarButtonWithImage(UIImage(named: R.image.setting.name)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "RootNaviViewController") {
            self.mainViewController = controller
        }
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "TestViewController") {
            self.leftViewController = controller
        }
        let controller = HelpViewController()
        self.rightViewController = controller
        
        super.awakeFromNib()
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
