//
//  HomeCollectionSectionHeaderView.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/4/18.
//  Copyright © 2020 张金山. All rights reserved.
//

import UIKit

class HomeCollectionSectionHeaderView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var  label : UILabel = {
       let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.textColor = HexColor(0x333333)
        label.text  = "艺术收藏网"
        return label
    }()
    
    func setUpViews() {
        self.backgroundColor = .white
        self.addSubview(self.label)
        self.label.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(12)
        }
    }
}
