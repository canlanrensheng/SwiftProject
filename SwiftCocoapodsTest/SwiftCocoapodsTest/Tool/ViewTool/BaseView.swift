//
//  BaseView.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/4/18.
//  Copyright © 2020 张金山. All rights reserved.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //自定义视图的部分
    func setUpViews() {
        
    }
}
