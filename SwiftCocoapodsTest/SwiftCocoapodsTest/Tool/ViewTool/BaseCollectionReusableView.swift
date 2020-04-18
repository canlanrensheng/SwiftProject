//
//  BaseCollectionReusableView.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/4/18.
//  Copyright © 2020 张金山. All rights reserved.
//

import UIKit

class BaseCollectionReusableView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpViews() {
        
    }
}
