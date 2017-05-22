//
//  AppDetailViewController.swift
//  swiftDemo
//
//  Created by xuhaoran on 2017/5/9.
//  Copyright © 2017年 SunFit. All rights reserved.
//

import UIKit
import DGElasticPullToRefresh
import HandyJSON
import Moya
import Alamofire
import Format


class AppDetailViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {

    // MARK:- 属性
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titileLine: UIView!
    
    var allApplist : [AppItem]!
    var versionArray :[String]!
    var dictArray :  [ Dictionary<String,Array<AppItem>>]!
    var lastClickBtn : UIButton!
    
    
    let btnGrayColor                = ColorFormatter().format("333333")
    let btnBlueColor                = ColorFormatter().format("2A9FFE")
    let cellID                      = "HistoryVersionTableViewCell"
    var prodTypeNum                 = Int()         // app 代号
    private     var envTypeNum      = 1             // 进入默认SIT
    private     var currentPageNum  = 1             // page
    
    
    // MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
        self.setNaviBackBtn()
        self.setupTableView()
        lastClickBtn = self.view.viewWithTag(100) as! UIButton
    }

    // MARK:- UI
    func setupTableView() {
        
        tableView.dataSource        = self;
        tableView.delegate          = self;
        tableView.separatorStyle    = .none
        tableView.rowHeight         = 60
        tableView .register(UINib.init(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = ColorFormatter().format("1B99FF")
        tableView.dg_addPullToRefreshWithActionHandler({ 
            
            self.queryAppDetail()
//            let delay = DispatchTime.now() + 1;
//            DispatchQueue.main.asyncAfter(deadline: delay, execute: { 
//                
//                self.tableView.dg_stopLoading()
//            })
            
        }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(ColorFormatter().format("FFFFFF"))
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
        
        
       
    }
    
    // MARK:- 数据处理
    func setupData() {
        
        self.allApplist     = []
        self.versionArray   = []
        self.dictArray      = []
    }
    
    func handleData() {
        
        if self.allApplist.count == 0 {
            
            self.tableView.reloadData()
            return
        }
        
        
        for item in self.allApplist {
            
            
            // 收集不同版本号
            var isRepeat = false
            
            for versionStr in self.versionArray {
                
                if versionStr == item.version {
                    isRepeat = true
                }
                break
            }
            
            if isRepeat == false {
                self.versionArray.append(item.version)
            }
         
            // 收集各个版本号下面的模型数据
            for versionStr in self.versionArray {
                
                var dict = Dictionary<String,[AppItem]>()
                var valueArr = [AppItem]()
                
                for appItem in self.allApplist {
                    
                    if versionStr == appItem.version {
                        
                        valueArr.append(appItem)
                    }
                }
                
                dict[versionStr] = valueArr
                
                self.dictArray.append(dict)

            }
            
            tableView.reloadData()
            
            
        }
        
        
        
    }
    
    
    
    // MARK:- 按钮事件
    @IBAction func titleBtnClick(_ btn: UIButton) {
        
        UIView.animate(withDuration: 0.3) {
            
//            titileLine.center = CGPoint(x: btn.center.x, y: <#T##CGFloat#>)
           self.titileLine.center.x = btn.center.x
        }
        
        self.envTypeNum = 1 + btn.tag - 100
        if lastClickBtn != nil {
            lastClickBtn .setTitleColor(btnGrayColor, for: .normal)
        }
        btn.setTitleColor(btnBlueColor, for: .normal)
        lastClickBtn = btn
        
    }
    
    // MARK:- 网络请求
    func queryAppDetail() {
        
        // 关闭证书验证
        let serverTrustPolicies: [String : ServerTrustPolicy] = ["172.16.88.230" : .disableEvaluation]
        
        let manager = Manager(configuration: .default, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
        
        let provider = MoyaProvider<ApiServiceUrl>(manager: manager , plugins: [NetworkLoggerPlugin(verbose: true)])
        
        provider.request(.specificAppList(prodType: prodTypeNum, envType: envTypeNum, platform: 1, pageNo: 1, pageSize: 100)) { (result) in
            
            switch result{
                
            case let .success(respones):
                do{
                    let jsonStr  = try respones.mapString()
                    print(jsonStr)
                    if let appItemArray = [AppItem].deserialize(from: jsonStr, designatedPath: "data") {
                        
                        self.allApplist = appItemArray as! [AppItem];
                        
                    }
                    self.tableView.dg_stopLoading()
                    
                }catch{
                    
                }
            case let .failure(error):
                
                print(error)
                self.tableView.dg_stopLoading()
                break
                
            }
        }
        
    
    }

    
    // MARK:- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.versionArray.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let array      = self.dictArray[section]
        return array.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell        = tableView.dequeueReusableCell(withIdentifier: cellID) as! AppItemCell
        
        if self.dictArray.count > 0 {
            
            let sectionDict    =  self.dictArray[indexPath.section]
            var sectionArr  =  Array(sectionDict.values)
            
            let item = sectionArr[0][indexPath.row]
            
            cell.appItem = item
        }

        return cell;
    }
    
    
    // MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView                  = UIView(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 30))
        headerView.backgroundColor      = ColorFormatter().format("F6F5FA")
        
        let versionLabel                = UILabel()
        versionLabel.backgroundColor    = UIColor.white
        versionLabel.frame              = CGRect.init(x: 10, y: 10, width: self.view.frame.width - 20, height: 30)
        versionLabel.textColor          = ColorFormatter().format("1B99FF")
        
        
        versionLabel.text               = "versionTest"
//        let dic = self.formattedDataArr[section]
//        versionLabel.text = "  " + Array(dic.keys)[0]
        
        headerView.addSubview(versionLabel)
        
        let lineLabel                   = UILabel()
        lineLabel.frame                 = CGRect.init(x: 10, y: 39, width: self.view.frame.width - 20, height: 1)
        lineLabel.backgroundColor       = ColorFormatter().format("DADADA")
        lineLabel.alpha                 = 0.6
        headerView.addSubview(lineLabel)
        
        return headerView

        
    }
}
