//
//  HomePageViewController.swift
//  swiftDemo
//
//  Created by xuhaoran on 2017/5/4.
//  Copyright © 2017年 SunFit. All rights reserved.
//

import UIKit
import DGElasticPullToRefresh
import Format
import Moya
import Alamofire
import HandyJSON

class HomePageViewController: BaseViewController ,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var appListArray :[AppItem]!
    
    var vcType = 0
    
    let cellID = "AppItemCell"
    
    
    // MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "首页"
        appListArray = []
        self.setupTableView()
        
    }
    
    

    // MARK:- UI
    func setupTableView() {
        
        tableView.register(UINib.init(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        tableView.rowHeight = 135;
        let loadingView = DGElasticPullToRefreshLoadingViewCircle.init()
        loadingView.tintColor = UIColor.white
        
        tableView.dg_addPullToRefreshWithActionHandler({ 
            
            self.queryAppList()
//            let delay = DispatchTime.now() + 2
//            DispatchQueue.main.asyncAfter(deadline: delay, execute: { 
//                self.tableView.dg_stopLoading()
//            })
            
        }, loadingView: loadingView)
        
        tableView.dg_setPullToRefreshFillColor(ColorFormatter().format("46BBFF"))
        tableView.backgroundColor = UIColor(patternImage: UIImage.init(named: "background")!)
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
        tableView.separatorStyle = .none
    

    }
    
    // MARK:- 网络请求
    func queryAppList() {
        
        
        // 关闭证书验证
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "172.16.88.230": .disableEvaluation
        ]
        
        let manager = Manager(
            configuration:.default,
            serverTrustPolicyManager:
            ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        
        let provider = MoyaProvider<ApiServiceUrl>(manager: manager, plugins: [NetworkLoggerPlugin(verbose: true
            )])
 
        
        
        provider.request(.allAppListUrl(platform: 1, pageNo: 1, pageSize: 1)) { (result) in
            
            switch result{
            
            case let .success(response):
                do{
                    let jsonStr = try response.mapString()
                    print("返回的json" + jsonStr)
                    
                    if let appArry = [AppItem].deserialize(from: jsonStr, designatedPath: "data"){
                        
                        self.appListArray = appArry as! [AppItem]
                    }
                    self.tableView.dg_stopLoading()
                    self.tableView.reloadData()
                    
                }catch{
                    
                }
                
                
            case let .failure(error):
                
                print(error)
                self.tableView.dg_stopLoading()
                
                
                
            }
            
            
            
        }
        
      
        
        
    }
    
    
    
    // MARK:- UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return appListArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! AppItemCell
        let item = appListArray[indexPath.row]
        cell.appItem = item;
        return cell
        
    }
    
    // MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header              = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: 10))
        header.backgroundColor  = UIColor.clear
        return header
    }
    
}
