//
//  JSButton.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/2/29.
//  Copyright © 2020 张金山. All rights reserved.
//

import UIKit
typealias clickEventBlock = () -> ()

class JSButton: UIButton {
    
    /*
    
    */
    class func createButton(frame : CGRect,title : String,titleColor : UIColor,font : UIFont,backgroundColor : UIColor,block : clickEventBlock) -> UIButton {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = frame
        button.setTitle(title, for: UIControl.State.normal)
        button.setTitleColor(titleColor, for: UIControl.State.normal)
        button.backgroundColor = backgroundColor
        button.target(forAction: #selector(buttonClick(button:)), withSender: self)
        objc_setAssociatedObject(button, "ButtonBlockKey", block, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC);
        return button
    }

    @objc func buttonClick(button : UIButton) -> Void {
        print("按钮的点击")
        let clickBlock : clickEventBlock = objc_getAssociatedObject(button, "ButtonBlockKey") as! clickEventBlock;
        clickBlock()
    }
}
