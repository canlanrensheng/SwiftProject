//
//  HomeGoodCollectionViewCell.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/4/18.
//  Copyright © 2020 张金山. All rights reserved.
//

import UIKit

import SnapKit
import Kingfisher

class HomeGoodCollectionViewCell: UICollectionViewCell {
    
    lazy var iconImageView :UIImageView = {
       let iconImageView = UIImageView.init()
        iconImageView.backgroundColor = UIColor.white
        return iconImageView
    }()
    
    lazy var nameLabel :UILabel = {
        let label  = UILabel.init()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.left
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    lazy var priceLabel : UILabel = {
        let label  = UILabel.createLabel(text: "", textColor: .red, textAlignment: .left, font: .systemFont(ofSize: 14), backgroundColor: .white)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    func setUpView() {
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.clipsToBounds = true
        self.contentView.addSubview(self.iconImageView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.priceLabel)
        self.iconImageView.snp_makeConstraints { (make) in
            make.left.top.right.equalTo(self.contentView)
            make.height.equalTo(171)
        }
        
        self.nameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.iconImageView).offset(10)
            make.top.equalTo(self.iconImageView.snp_bottom).offset(6)
            make.right.equalTo(self.contentView).offset(-10)
        }
        
        self.priceLabel.snp_makeConstraints { (make) in
           make.left.equalTo(self.nameLabel)
           make.top.equalTo(self.nameLabel.snp_bottom).offset(10)
           make.height.equalTo(17)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData(model : RecommendList) {
//        self.iconImageView.kf.setImage(with: model.mainPhoto as! Resource, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        self.iconImageView.kf.setImage(with: URL(string: model.mainPhoto))
        self.nameLabel.text = model.goodsName
        self.priceLabel.text = "¥" + model.goodsPrice
    }
    
}
