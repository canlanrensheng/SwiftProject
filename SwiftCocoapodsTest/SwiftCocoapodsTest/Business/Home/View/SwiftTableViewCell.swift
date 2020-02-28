//
//  SwiftTableViewCell.swift
//  swiftUI
//
//  Created by 张金山 on 2020/2/3.
//  Copyright © 2020 张金山. All rights reserved.
//

import UIKit
import SnapKit

class SwiftTableViewCell: UITableViewCell {
    var iconImageView : UIImageView?
    var nameLabel : UILabel?
    var contentLabel : UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        self.iconImageView = UIImageView()
        self.iconImageView!.backgroundColor = tableViewBackGroundColor
        self.addSubview(self.iconImageView!)
        self.iconImageView!.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(10)
            make.width.height.equalTo(40)
            make.top.equalTo(self).offset(10)
        })

        self.nameLabel = UILabel.init()
        self.nameLabel!.text = "小明"
        self.nameLabel?.textColor = UIColor.black
        self.nameLabel?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(self.nameLabel!)
        self.nameLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self.iconImageView!.snp.right).offset(10)
            make.right.equalTo(self).offset(-10)
        })

        self.contentLabel = UILabel.init()
        self.contentLabel!.text = "你发给我们的那水果群买菜群啥的，生意可好了,你发给我们的那水果群买菜群啥的，生意可好了,你发给我们的那水果群买菜群啥的，生意可好了,你发给我们的那水果群买菜群啥的，生意可好了"
        self.contentLabel!.textColor = UIColor.gray
        self.contentLabel!.numberOfLines = 0
        self.contentLabel!.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(self.contentLabel!)
        self.contentLabel!.snp.makeConstraints({ (make) in
            make.top.equalTo(self.nameLabel!.snp.bottom).offset(5)
            make.left.equalTo(self.nameLabel!)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self).offset(-10)
        })
    }
}
