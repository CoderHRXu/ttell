//
//  HomeViewController.swift
//  Ttel
//
//  Created by PandaApe on 1/8/17.
//  Copyright © 2017 PandaApe. All rights reserved.
//

import UIKit
import HandyJSON
import DGElasticPullToRefresh
import Format
import Alamofire
import Moya


class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource ,UIAlertViewDelegate {
    
    // MARK:- property
    @IBOutlet weak var appsTableView: UITableView!
    
    lazy var appVModel = AppVModel()
    
    var appList:[AppItem]!
    
    var newTtelItem = AppItem();
    
    
    open var vcType = 0
    
    // MARK:- lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavBar()
        self.initData()
        self.initSubviews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      
    }
    
    // MARK:- UI
    func initNavBar() {
        
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"setting"), style: .plain, target: self, action: #selector(leftNaviBtnClicked))
//        self.title = "Ttel"
        self.parent?.addLeftBarButtonWithImage(UIImage(named:"setting")!)
//        self.addLeftBarButtonWithImage(UIImage(named:"setting")!)
        self.parent?.title = "Ttel"
    }
    
    func initData() {
        
        self.appList = []
        
        self.queryAppList()
    }
    
    func initSubviews() {

        self.appsTableView.register(R.nib.appItemCell)
        
        let loadingView         = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor   = UIColor.white
        
        appsTableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            
            self?.queryAppList()
            
            }, loadingView: loadingView)
        
        appsTableView.dg_setPullToRefreshFillColor(ColorFormatter().format("46BBFF"))
        appsTableView.dg_setPullToRefreshBackgroundColor(appsTableView.backgroundColor!)
        print(R.image.background()!.size.width)
        appsTableView.backgroundColor                   = UIColor.init(patternImage: R.image.background()!)
        self.setWebBackgroundView(tableView: self.appsTableView)
        
        let leftVC                                       = self.slideMenuController()?.leftViewController as! LeftMenuViewController
        leftVC.delegate                                  = self
        slideMenuController()?.leftPanGesture?.isEnabled = false
        if #available(iOS 11.0, *) {
            appsTableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
    
    }
    
    // MARK:- action
    @IBAction @objc func leftNaviBtnClicked(_ sender: Any) {
        
        self.slideMenuController()?.changeLeftViewWidth(self.view.bounds.size.width/2 + 70)
        self.slideMenuController()?.openLeft()
    }
    
    @IBAction func rightNaviBtnClicked(_ sender: Any) {
        
        self.slideMenuController()?.openRight()
        
    }
    
    
    // MARK:- UITableViewDataSource,UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.appList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 135
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 10))
        
        headerView.backgroundColor = UIColor.clear
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let appCell = tableView.dequeueReusableCell(withIdentifier:R.nib.appItemCell.identifier, for: indexPath) as! AppItemCell
        let item = self.appList[indexPath.section]
        appCell.appItem = item
        
        return appCell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = AppDetailViewController(nib: R.nib.appDetailViewController)
        
        let selectedCell = tableView .cellForRow(at: indexPath) as! AppItemCell
        
        detailVC.title = selectedCell.appItem?.displayName
        
        detailVC.prodTypeNum = (selectedCell.appItem?.prodType)!
        
        detailVC.envTypeNum = (selectedCell.appItem?.envType)!
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - network
    /// 查询app列表
    func queryAppList() {
        
        
        appVModel.listAllProds(pageNo: 1, pageSize: 15).then { [weak self] items -> Void in
            print(items)
            
            self?.appList = items
            
            self?.checkAppVersion();
            
            }.catch { (error) in
                print("error->\(error)")
            }.always {
                self.appsTableView.reloadData()
                self.appsTableView.dg_stopLoading()
        }
    }
    
    func checkAppVersion() {
        
        for item in self.appList {
            
            if item.prodType == 1081 && item.envType == 3{
                
                let sysInfo = SystemInfo().getSystemInfo();
                
                if sysInfo.appVer != item.version {
                    
                    self.newTtelItem = item;
                    
                    self.showAlertView();
                }
            }
        }
    }
    
    
    func alertView(_ alertView: UIAlertView, willDismissWithButtonIndex buttonIndex: Int) {
        
        if buttonIndex == 0 {
            
            let url = URL(string: self.newTtelItem.downloadUrl)!
            
            if UIApplication.shared.canOpenURL(url) {
                
                UIApplication.shared.openURL(url)
                
            }else{
                
            }
        }
    }
    
    func alertView(_ alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        
        self.showAlertView();
    }
    
    func showAlertView() {
        
        let alertView = UIAlertView.init(title: "更新", message: "Ttel 已有新版本，请更新后继续使用。", delegate: self, cancelButtonTitle: "更新")
        alertView.show();
    }
    
    deinit {
        
        appsTableView?.dg_removePullToRefresh()
    }
    
}


extension HomeViewController : LeftMenuDelegate {
    
    
    func leftMenuDidClickGotoHelp(leftMenu : LeftMenuViewController){
        
        self.slideMenuController()?.closeLeft()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
            self.navigationController?.pushViewController(HelpViewController(), animated: true)
        }
    }
    
    func leftMenuDidClickGotoAbout(leftMenu : LeftMenuViewController){
        
        self.slideMenuController()?.closeLeft()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
            self.navigationController?.pushViewController(AboutViewController(), animated: true)
        }
    }
    
    func leftMenuDidClickGotoSetting(leftMenu: LeftMenuViewController) {
        self.slideMenuController()?.closeLeft()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
            self.navigationController?.pushViewController(SettingViewController(), animated: true)
        }
    }
}
