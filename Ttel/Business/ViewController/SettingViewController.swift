//
//  SettingViewController.swift
//  Ttel
//
//  Created by PandaApe on 19/04/2017.
//  Copyright © 2017 Sunfit. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class SettingViewController: BaseViewController {
    
    // MARK: - IBUnit
    @IBOutlet weak var serverTF: UITextField!
    
    @IBOutlet weak var portTF: UITextField!
    
    let disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackIcon()
        configData()
        configUI()
    }
    
    func configData() {
        serverTF.text = CacheHandler.sharedInstance.baseUrlString
        portTF.text = CacheHandler.sharedInstance.port
    }
    
    func configUI() {
        // Navi Title
        self.navigationItem.title = "设置"
        // Right navi btn
        let barItem = UIBarButtonItem(title: "修改", style: UIBarButtonItemStyle.plain, target: self, action: #selector(rightBtnClicked))
        navigationItem.rightBarButtonItem = barItem;
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        serverTF.rx.controlEvent(.editingChanged).subscribe(onNext: { [unowned self] in

            self.enableRightBtn()
        }).disposed(by: disposeBag)
        
        portTF.rx.controlEvent(.editingChanged).subscribe(onNext: { [unowned self] in
            
            self.enableRightBtn()
        }).disposed(by: disposeBag)
    }
    
    @objc fileprivate func rightBtnClicked(){
        
        view.endEditing(true)
        let aletVC = UIAlertController.init(title: "确定修改相关配置么?", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "修改", style: .default) { (action) in
            self.saveConfig()
        }
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel) { (action) in
            
        }
        aletVC.addAction(okAction)
        aletVC.addAction(cancelAction)
        self.present(aletVC, animated: true, completion: nil)
        
    }
    
    fileprivate func saveConfig() {
        
        CacheHandler.sharedInstance.baseUrlString = serverTF.text!
        CacheHandler.sharedInstance.port = portTF.text!
        let aletVC = UIAlertController.init(title: "修改成功", message: "配置修改后，请注意重新下载并信任https证书", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "我知道了", style: .default) { (action) in
            
            self.navigationController?.popViewController(animated: true)
        }
        aletVC.addAction(okAction)
        self.present(aletVC, animated: true, completion: nil)
    }
    
    fileprivate func enableRightBtn(){
        if navigationItem.rightBarButtonItem?.isEnabled == false {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
