 //
 //  AppItemCell.swift
 //  Ttel
 //
 //  Created by xuhaoran on 2017/4/6.
 //  Copyright © 2017年 PandaApe. All rights reserved.
 //
 
 import UIKit
 import Kingfisher
 import Format
 
 class AppItemCell: UITableViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var installBtn: UIButton!
    @IBOutlet weak var buildNumLabel: UILabel!
    @IBOutlet weak var updateDateLabel: UILabel!
    @IBOutlet weak var appSizeLabel: UILabel!
    
    var appItem : AppItem?{
        
        didSet{
            if let item = appItem {
                
                let iconUrl                 = URL(string: item.iconUrl)
                
                
                let downloader = KingfisherManager.shared.downloader
                downloader.trustedHosts = Set(["172.16.88.230"])
                
                iconView.kf.setImage(with: iconUrl)
                appNameLabel.text           = item.displayName;
                versionLabel.text           = "V" + item.version;
                switch item.envType {
                case 1:
                    typeLabel.text          = "SIT"
                case 2:
                    typeLabel.text          = "UAT"
                case 3:
                    typeLabel.text          = "PRO"
                case 4:
                    typeLabel.text          = "ARC"
                default: break
                    
                }
                buildNumLabel.text          = item.buildVersion;
                let timeStr                 = self.timeStampToString(timeStamp: item.updatedDate/1000)
                updateDateLabel.text        = timeStr
                let size : Double           = (item.fileSize as NSString).doubleValue
                let sizeStr                 = String(format: "%.2f", size / 1024 / 1024)
                appSizeLabel.text           = "\(sizeStr)MB"
            }
        }
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.layer.cornerRadius         = 5;
        self.layer.masksToBounds        = true
        typeLabel.layer.borderColor     = ColorFormatter().format("1C99FF").cgColor
        typeLabel.layer.borderWidth     = 1
        typeLabel.layer.cornerRadius    = 3;
        typeLabel.layer.masksToBounds   = true;
        installBtn.layer.cornerRadius   = 5;
        installBtn.layer.masksToBounds  = true;
        
        self.iconView?.layer.masksToBounds  = true
        self.iconView?.layer.cornerRadius   = 10
        self.iconView?.layer.borderColor    = ColorFormatter().format("EAEAEA").cgColor
        self.iconView?.layer.borderWidth    = 1
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func installBtnClick(_ sender: UIButton) {
        
        let url = URL(string: self.appItem!.downloadUrl)!
        if UIApplication.shared.canOpenURL(url) {
            
            UIApplication.shared.openURL(url)
            
        }else{
            
        }
    }
    
    private func timeStampToString(timeStamp:Int64)->String {
        
        let timeSta             = TimeInterval(timeStamp)
        let dfmatter            = DateFormatter()
        
        dfmatter.dateFormat     = "MM-dd HH:mm"
        let date                = NSDate(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date as Date)
    }
    
 }
