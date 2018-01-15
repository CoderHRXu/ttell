//
//  HistoryVersionCell.swift
//  Ttel
//
//  Created by WeiWei on 2017/4/17.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

import UIKit
import Kingfisher
import Format

class HistoryVersionCell: UITableViewCell {
    
    @IBOutlet weak var buildNumLabel: UILabel!
    @IBOutlet weak var updateDateLabel: UILabel!
    @IBOutlet weak var appSizeLabel: UILabel!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var dashedLineLabel: UILabel!
    @IBOutlet weak var prodTypeLabel: UILabel!
    
    //    var showProdTypelabel = Bool();
    
    let border: CAShapeLayer = CAShapeLayer()
    
    func createDashedLine(){
        
        self.dashedLineLabel.layer.masksToBounds = true
        //线的颜色
        self.border.strokeColor = ColorFormatter().format("DADADA").cgColor
        //设置填充色
        self.border.fillColor = UIColor.darkGray.cgColor
        //虚线大小
        self.border.lineDashPattern = [3,3]
        //添加到layer
        self.dashedLineLabel.layer.addSublayer(self.border)
        //画一条虚线
        // 创建path
        let path = UIBezierPath()
        // 添加路径[1条点(x,y)到点(x,y)的线段]到path
        path.move(to: CGPoint.init(x: 0, y: 0))
        path.addLine(to: CGPoint.init(x: UIScreen.main.applicationFrame.width, y: 0))
        
        self.border.path = path.cgPath
    }
    
    var appItem : AppItem?{
        
        didSet{
            
            if let item = appItem {
                
                buildNumLabel.text          = item.buildVersion;
                let timeStr                 = self.timeStampToString(dateStr: item.updatedDate)
                updateDateLabel.text        = timeStr
                let size : Double           = (item.fileSize as NSString).doubleValue
                let sizeStr                 = String(format: "%.2f", size / 1024 / 1024)
                appSizeLabel.text           = "\(sizeStr)MB"
            }
        }
    }
    
    var showProdTypelabel: Bool?{
        
        didSet{
            
            self.showItemProdType(isShow: self.showProdTypelabel!);
        }
    }
    
    
    func showItemProdType(isShow:Bool) {
        
        self.prodTypeLabel.isHidden = !isShow;
        
        self.prodTypeLabel.layer.masksToBounds = true;
        
        self.prodTypeLabel.layer.cornerRadius = 2.5;
        
        self.prodTypeLabel.layer.borderWidth = 1;
        
        self.prodTypeLabel.layer.borderColor = ColorFormatter().format("1B99FF").cgColor;
        
        var envName = String();
        
        guard let envType = self.appItem?.envType else {
            
            return;
        }
        
        switch envType {
        case 1:
            envName = "SIT"
        case 2:
            envName = "UAT"
        case 3:
            envName = "线上包"
        case 4:
            envName = "归档包"
        default:
            envName = ""
        }
        
        self.prodTypeLabel.text = envName;
    }
    
    private func timeStampToString(dateStr:String)->String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        // 设置系统时区为本地时区
        let zone = NSTimeZone.system
        // 计算本地时区与 GMT 时区的时间差
        let second:Int = zone.secondsFromGMT()
        
        var realDate = dateFormatter.date(from: dateStr)
        realDate = realDate?.addingTimeInterval(TimeInterval(second))
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "MM-dd HH:mm"
        
        let formatStr = dateFormatter2.string(from: realDate!)
        
        return formatStr
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.createDashedLine()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
