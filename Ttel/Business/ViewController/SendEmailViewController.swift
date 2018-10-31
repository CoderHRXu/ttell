//
//  SendEmailViewController.swift
//  Ttel
//
//  Created by WeiWei on 2017/5/26.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

import UIKit
import DGElasticPullToRefresh
import Format
import PKHUD

class SendEmailViewController: BaseViewController ,UITableViewDataSource ,UITableViewDelegate{
    
    var prodTypeNum = Int();
    var versionStr = String();
    var itemsArr = Array<AppItem>();
    var emailAddressesArr = Array<String>();
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emailInputView: UITextView!
    @IBOutlet weak var tableViewHeightConstrains: NSLayoutConstraint!
    
    @IBOutlet weak var sendBtn: UIButton!
    
    lazy var appVModel = AppVModel();
    
    
    // MARK: - init
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.initNavBar();
        
        self.setBackIcon();
        
        self.initSubviews();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tableViewHeightConstrains.constant = CGFloat(40 + self.itemsArr.count * 60);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initNavBar() {
        
        self.title = "发送到邮箱";
    }
    
    func initSubviews() {
        
        self.sendBtn.layer.masksToBounds = true;
        self.sendBtn.layer.cornerRadius = 3;
        
        self.tableView.bounces = false;
        
        self.tableView.dataSource   = self
        self.tableView.delegate     = self
        
        self.tableView.register(UINib.init(nibName: "HistoryVersionCell", bundle: nil), forCellReuseIdentifier: "HistoryVersionCell")
        
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        
        loadingView.tintColor = ColorFormatter().format("1B99FF")
                
        self.tableView.dg_setPullToRefreshFillColor(ColorFormatter().format("FFFFFF"))
        self.tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        if (UserDefaults.standard.value(forKey: "emailAddressArr") != nil) {
            
            self.emailAddressesArr = UserDefaults.standard.value(forKey: "emailAddressArr") as! Array<String>;
            
            var emailAddressStr = String();
            
            for str in self.emailAddressesArr {
                
                emailAddressStr = emailAddressStr.appending(str);
                emailAddressStr = emailAddressStr.appending("\n");
            }
            self.emailInputView.text = emailAddressStr;
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardShow(noti:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardHide(noti:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    // MARK: - tableview datasource & delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.itemsArr.count;
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 45;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 35)
        headerView.backgroundColor = ColorFormatter().format("F6F5FA")
        
        let versionLabel = UILabel()
        versionLabel.backgroundColor = UIColor.white
        versionLabel.frame = CGRect.init(x: 10, y: 10, width: self.view.frame.width - 20, height: 35)
        versionLabel.textColor = ColorFormatter().format("1B99FF")
        
        let appName = self.itemsArr[0].displayName;
        
        versionLabel.text = String.init(format: "  %@ V%@", appName!,self.versionStr);
        
        headerView.addSubview(versionLabel)
        
        let lineLabel = UILabel()
        lineLabel.frame = CGRect.init(x: 10, y: 44, width: self.view.frame.width - 20, height: 1)
        lineLabel.backgroundColor = ColorFormatter().format("DADADA")
        lineLabel.alpha = 0.6
        
        headerView.addSubview(lineLabel)
       
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let appCell = tableView.dequeueReusableCell(withIdentifier: "HistoryVersionCell") as! HistoryVersionCell
        
        if self.itemsArr.count > 0 {
            
            let item = self.itemsArr[indexPath.row]
            
            appCell.appItem = item
            
            appCell.showProdTypelabel = true;
        }
        
        return appCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: true);
        
        self.hiddenKeyBoardAndResetView();
    }
    
    // MARK: - handel data
    func getInputedEmailAddresses() -> Bool{
        
        self.emailAddressesArr = Array<String>();
        
        if (self.emailInputView.text != nil && self.emailInputView.text.characters.count > 0) {
            
            var arr = self.emailInputView.text.components(separatedBy: "\n");
            
            for str in arr {
                
                let strTemp = str.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines);
                
                if strTemp.characters.count == 0 {
                    
                    arr.remove(at: arr.index(of: str)!);
                    
                    continue;
                }
                
                if !self.validateEmail(email: str) || !((strTemp.contains("@sunfit.cn") || strTemp.contains("@rjs.com"))) {
                    
                    HUD.flash(.label("邮箱校验失败"), delay: 2.0);
                    
                    return false;
                }
            }
            
            print(arr)
            
            self.emailAddressesArr = arr;
            
            return true;
            
        }else{
            HUD.flash(.label("请输入内容"), delay: 2.0);
            return false;
        }
    }
    
    func validateEmail(email: String) -> Bool {
        let emailString = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailString)
        return emailPredicate.evaluate(with: email)
    }
    
    // MARK: - btn action
    @IBAction func sendEmailBtnClicked(_ sender: UIButton) {
        
        HUD.flash(.progress);
//        HUD.flash(.progress, onView: view)
        
        sender.isUserInteractionEnabled = false;
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            sender.isUserInteractionEnabled = true;
        }
        
        self.hiddenKeyBoardAndResetView();
        
        if self.getInputedEmailAddresses() {
            
            UserDefaults.standard.set(self.emailAddressesArr, forKey: "emailAddressArr");
            
            var appIds = Array<String>();
            
            for item in self.itemsArr {
                
                appIds.append(item.itemId);
            }
            
            appVModel.SendEmailToTester(itemIds: appIds, receivers: self.emailAddressesArr) .done {
                (result) -> Void in
                
                _ = result;
                
                print(result);
                
                HUD.flash(.label("邮件发送成功"), delay: 2.0);
                
                self.popToLastVC();
                
                }.catch{_ in
                    HUD.hide(afterDelay: 0);
                }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.hiddenKeyBoardAndResetView();
    }

    func hiddenKeyBoardAndResetView() {
        
        self.emailInputView.resignFirstResponder();
    }
    
    func keyBoardShow(noti:NSNotification) {
        
        //        let keyBoardRect = noti.userInfo?[UIKeyboardFrameEndUserInfoKey] as! CGRect;
        //
        //        let keyBoardHeight = keyBoardRect.size.height;
        
        UIView.animate(withDuration: 0.3) {
            
            self.view.frame.origin.y = -self.tableViewHeightConstrains.constant + 64;
        }
    }
    
    func keyBoardHide(noti:NSNotification) {
        
        UIView.animate(withDuration: 0.2) {
            
            self.view.frame.origin.y = 0 + 64;
        }
    }
}
