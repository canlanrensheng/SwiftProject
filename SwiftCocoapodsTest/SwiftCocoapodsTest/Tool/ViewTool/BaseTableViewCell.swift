//
//  BaseTableViewCell.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/4/18.
//  Copyright © 2020 张金山. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置视图
    func setUpViews() {
        
    }

}
