//
//  HistoryVersionTableViewCell.swift
//  Ttel
//
//  Created by WeiWei on 2017/4/17.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

import UIKit
import Kingfisher
import Format

class HistoryVersionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var buildNumLabel: UILabel!
    @IBOutlet weak var updateDateLabel: UILabel!
    @IBOutlet weak var appSizeLabel: UILabel!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var dashedLineLabel: UILabel!
    
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
                let timeStr                 = self.timeStampToString(timeStamp: item.updatedDate)
                updateDateLabel.text        = timeStr
                let size : Double           = (item.fileSize as NSString).doubleValue
                let sizeStr                 = String(format: "%.2f", size / 1024 / 1024)
                appSizeLabel.text           = "\(sizeStr)MB"
            }
        }
    }
    
    private func timeStampToString(timeStamp:String)->String {
        
//        let timeSta             = TimeInterval(timeStamp)
//        let dfmatter            = DateFormatter()
//        
//        dfmatter.dateFormat     = "MM-dd HH:mm"
//        let date                = NSDate(timeIntervalSince1970: timeSta)
//        return dfmatter.string(from: date as Date)
        
        // 先把字符串转换成nsdate   2017-07-01T13:04:37.000Z
        let formatter           = DateFormatter()
        formatter.dateFormat    = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let realDate            = formatter.date(from: timeStamp)
        
        let dfmatter            = DateFormatter()
        dfmatter.dateFormat     = "MM-dd HH:mm"
        return dfmatter.string(from: realDate!)
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
