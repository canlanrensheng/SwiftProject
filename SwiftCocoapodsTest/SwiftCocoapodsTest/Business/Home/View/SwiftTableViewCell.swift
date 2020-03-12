//
//  SwiftTableViewCell.swift
//  swiftUI
//
//  Created by 张金山 on 2020/2/3.
//  Copyright © 2020 张金山. All rights reserved.
//

import UIKit


class SwiftTableViewCell: UITableViewCell {
    
    var iconImageView : UIImageView = {
        return JSImageView.createImageView(imageName: "", backgroundColor: tableViewBackGroundColor)
    }()
    var nameLabel : UILabel = {
        return JSLabel.createLabel(text: "", textColor: blackColor, textAlignment: NSTextAlignment.left, font:RegularFont(size: 14), backgroundColor: UIColor.clear)
    }()
    var contentLabel : UILabel = {
        return JSLabel.createLabel(text: "", textColor: TextColor, textAlignment: NSTextAlignment.left, font: RegularFont(size: 14), backgroundColor: UIColor.clear)
    }()
    
    var publishButton : UIButton = {
        return  JSButton.createButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), title: "发布", titleColor: UIColor.red, font: UIFont.systemFont(ofSize: 14), backgroundColor: UIColor.clear) {
            print("我被点击了")
        }
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        self.addSubview(self.iconImageView)
        self.iconImageView.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(10)
            make.width.height.equalTo(40)
            make.top.equalTo(self).offset(10)
        })

        self.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self.iconImageView.snp.right).offset(10)
            make.right.equalTo(self).offset(-10)
        })

        self.addSubview(self.contentLabel)
        self.contentLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(5)
            make.left.equalTo(self.nameLabel)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self).offset(-10)
        })
        
        self.addSubview(self.publishButton)
        self.publishButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView).offset(-12);
            make.centerY.equalTo(self.contentView)
            make.size.equalTo(CGSize(width: 40, height: 20))
        }

     }
}
