//
//  AppDetailViewController.swift
//  Ttel
//
//  Created by WeiWei on 2017/4/17.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

import UIKit
import HandyJSON
import DGElasticPullToRefresh
import Format
import Alamofire
import Moya

class AppDetailViewController: BaseViewController ,UITableViewDataSource ,UITableViewDelegate{
    
    var prodTypeNum = Int()
    var envTypeNum = Int()
    var currentPageNum = Int()
    
    let pageSizeNum = 10
    
    lazy var appVModel = AppVModel()
    
    
    // MARK: - properties
    @IBOutlet weak var deatilTableView: UITableView!
    @IBOutlet weak var SITBtn: UIButton!
    @IBOutlet weak var UATBtn: UIButton!
    @IBOutlet weak var PROBtn: UIButton!
    @IBOutlet weak var ARCBtn: UIButton!    // ARC 存档备份包
    @IBOutlet weak var blueLineLabel: UILabel!
    
    var allAppList : [AppItem]!
    
    var formattedDataArr : [Dictionary<String, Array<AppItem>>]!
    
    var versionArr = [String]()
    
    
    // MARK: - life cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setBackIcon()
        
        self.initData()
        
        self.initSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        
        if self.envTypeNum > 0 {
            
            switch self.envTypeNum {
                
            case 1:
                self.SITBtnClicked(self.SITBtn)
            case 2:
                self.UATBtnClicked(self.UATBtn)
            case 3:
                self.PROBtnClicked(self.PROBtn)
            case 4:
                self.ARCBtnClicked(self.ARCBtn)
            default:
                return
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initData() {
        
        self.allAppList = []
        self.formattedDataArr = []
        self.versionArr = []
        
        self.currentPageNum = 1
        
        self.requestAppDetail()
    }
    
    
    func initSubviews() {
        
        self.deatilTableView.dataSource   = self
        self.deatilTableView.delegate     = self
        
        self.allAppList = []
        
        self.deatilTableView.register(UINib.init(nibName: "HistoryVersionCell", bundle: nil), forCellReuseIdentifier: "HistoryVersionCell")
        
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        
        loadingView.tintColor = ColorFormatter().format("1B99FF")
        
        self.deatilTableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            
            self?.initData()
            
            }, loadingView: loadingView)
        
        self.deatilTableView.dg_setPullToRefreshFillColor(ColorFormatter().format("FFFFFF"))
        self.deatilTableView.dg_setPullToRefreshBackgroundColor(deatilTableView.backgroundColor!)
        self.deatilTableView.separatorStyle = .none
        
        if #available(iOS 11.0, *) {
            self.deatilTableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    
    func backAction() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - network
    func requestAppDetail() {
        
        appVModel.ListSpecificProd(prodType: self.prodTypeNum, envType: self.envTypeNum, pageNo: 1, pageSize: 100).then{
            (items) -> Void in
            
            self.formattedDataArr = items
            
            for item in items {
                
                for key in item.keys{
                    
                    self.versionArr.append(key);
                }
            }
            
            }.always {
                self.deatilTableView.dg_stopLoading()
                self.deatilTableView.reloadData()
        }
        
    }
    
    
    // MARK: - handle data
    func handelData(allDataArr:[AppItem]) {
        
        if allDataArr.count == 0 {
            
            self.deatilTableView .reloadData()
            
            return
        }
        
        for appItem in allDataArr {
            
            var isRepeat = 0
            
            for versionStr in self.versionArr {
                
                if appItem.version == versionStr  {
                    
                    isRepeat = 1
                    
                    break
                }
            }
            
            if isRepeat == 0 {
                
                self.versionArr.append(appItem.version)
            }
        }
        
        for versionStr in self.versionArr {
            
            var dict = Dictionary<String,[AppItem]>()
            
            var valueArr = [AppItem]()
            
            for appItem in allDataArr {
                
                if versionStr == appItem.version {
                    
                    valueArr.append(appItem)
                }
            }
            
            dict[versionStr] = valueArr
            
            self.formattedDataArr.append(dict)
        }
        
        self.deatilTableView.reloadData()
    }
    
    
    // MARK: - tableview datasource & delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.formattedDataArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Array(self.formattedDataArr[section].values)[0].count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 45
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
        
        let dic = self.formattedDataArr[section]
        versionLabel.text = "  " + Array(dic.keys)[0]
        
        headerView.addSubview(versionLabel)
        
        let lineLabel = UILabel()
        lineLabel.frame = CGRect.init(x: 10, y: 44, width: self.view.frame.width - 20, height: 1)
        lineLabel.backgroundColor = ColorFormatter().format("DADADA")
        lineLabel.alpha = 0.6
        
        headerView.addSubview(lineLabel)
        
        if self.envTypeNum == 4 {
            
            let imgView = UIImageView.init(frame: CGRect.init(x: self.view.frame.width - 45, y: 15, width: 25, height: 25));
            imgView.image = UIImage.init(named: "send");
            headerView.addSubview(imgView);
            
            // 归档包 跳至 发送邮件页面
            
            let btn = UIButton.init(frame: headerView.frame);
            
            btn.tag = section + 100;
            
            headerView.addSubview(btn);
            
            btn.addTarget(self, action:#selector(jumpToSendEmailVC(sender:)), for: .touchUpInside);
        }
        
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let appCell = tableView.dequeueReusableCell(withIdentifier: "HistoryVersionCell") as! HistoryVersionCell
        
        if self.formattedDataArr.count > 0 {
            
            let sectionDict = self.formattedDataArr[indexPath.section]
            
            var sectionArr = Array(sectionDict.values)
            
            let item = sectionArr[0][indexPath.row]
            
            appCell.appItem = item
            
            if self.envTypeNum == 4 {
                appCell.showProdTypelabel = true
            }
            else{
                appCell.showProdTypelabel = false
            }
        }
        
        return appCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedCell = tableView.cellForRow(at: indexPath) as! HistoryVersionCell
        
        let url = URL(string: selectedCell.appItem!.downloadUrl)!
        if UIApplication.shared.canOpenURL(url) {
            
            UIApplication.shared.openURL(url)
            
        }else{
            
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        return .delete
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! HistoryVersionCell
        
        self.deleteItemRequest(itemId: (cell.appItem?.itemId)!)
    }
    
    // MARK: - click actions
    @IBAction func SITBtnClicked(_ sender: UIButton) {
        
        self.envTypeNum = 1
        
        self.updateViewValues(sender: sender)
    }
    @IBAction func UATBtnClicked(_ sender: UIButton) {
        
        self.envTypeNum = 2
        
        self.updateViewValues(sender: sender)
    }
    @IBAction func PROBtnClicked(_ sender: UIButton) {
        
        self.envTypeNum = 3
        
        self.updateViewValues(sender: sender)
    }
    @IBAction func ARCBtnClicked(_ sender: UIButton) {
        
        self.envTypeNum = 4
        
        self.updateViewValues(sender: sender)
    }
    
    
    func updateViewValues(sender:UIButton!) {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.blueLineLabel.center.x = sender.center.x
        })
        
        self.blueLineLabel.center.x = sender.center.x
        
        for i:Int in 1...4 {
            
            let btn = view.viewWithTag(i) as! UIButton
            
            btn.setTitleColor(ColorFormatter().format("333333"), for: UIControlState.normal)
        }
        
        sender .setTitleColor(ColorFormatter().format("2A9FFE"), for: UIControlState.normal)
        
        self.initData()
    }
    
    // MARK: - jump to emailVC
    func jumpToSendEmailVC(sender:UIButton) {
        
        let sendEmailVC = SendEmailViewController(nib: R.nib.sendEmailViewController);
        
        sendEmailVC.prodTypeNum = self.prodTypeNum;
        
        sendEmailVC.versionStr  = self.versionArr[(sender.tag - 100)];
        
        var itemArr = Array<AppItem>();
        
        for dict in self.formattedDataArr {
            
            for (key,value) in dict {
                
                if key == sendEmailVC.versionStr {
                    
                    for item in value {
                        
                        itemArr.append(item);
                    }
                }
            }
        }
        
        sendEmailVC.itemsArr = itemArr;
        
        
        self.navigationController?.pushViewController(sendEmailVC, animated: true);
    }
    
    // MARK: - deinit
    deinit {
        
        deatilTableView?.dg_removePullToRefresh()
    }
}

extension AppDetailViewController {
    
    func deleteItemRequest(itemId: String) {
        
        self.appVModel.deleteItem(itemId: itemId).then { (item) -> Void in
            
            print("删除成功--->",itemId)
            self.requestAppDetail()
            }.catch { (error) in
                
        }
    }
}
