//
//  JSButton.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/2/29.
//  Copyright © 2020 张金山. All rights reserved.
//

import UIKit

typealias clickEventBlock = () -> ()

var clickBlock : clickEventBlock = {}

enum ButtonLayoutStyle {
    case ButtonLayoutStyleImagePositionLeft
    case ButtonLayoutStyleImagePositionRight
    case ButtonLayoutStyleImagePositionTop
    case ButtonLayoutStyleImagePositionBottom
}

class JSButton: UIButton {
    
    /*
     frame : frame
     imageName : 图片
     block : 点击事件的闭包
    */
    class func createButton(frame : CGRect,imageName : String,block : @escaping clickEventBlock) -> UIButton {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = frame
        button.setImage(UIImage.init(named: imageName), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(buttonClick(button:)), for: UIControl.Event.touchUpInside)
        objc_setAssociatedObject(button, "ButtonBlockKey", block, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        clickBlock = block
        return button
    }
    
    /*
     title : title
     titleColor : titleColor
     font : font
     backgroundColor : backgroundColor
     block : block
    */
    class func createButton(title : String,titleColor : UIColor,font : UIFont,backgroundColor : UIColor,block : @escaping clickEventBlock) -> UIButton {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        button.setTitle(title, for: UIControl.State.normal)
        button.setTitleColor(titleColor, for: UIControl.State.normal)
        button.backgroundColor = backgroundColor
        button.addTarget(self, action: #selector(buttonClick(button:)), for: UIControl.Event.touchUpInside)
        objc_setAssociatedObject(button, "ButtonBlockKey", block, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        clickBlock = block
        return button
    }
    
    /*
     frame : frame
     title : title
     titleColor : titleColor
     font : font
     backgroundColor : backgroundColor
     block : block
    */
    class func createButton(frame : CGRect,title : String,titleColor : UIColor,font : UIFont,backgroundColor : UIColor,block : @escaping clickEventBlock) -> UIButton {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = frame
        button.setTitle(title, for: UIControl.State.normal)
        button.setTitleColor(titleColor, for: UIControl.State.normal)
        button.backgroundColor = backgroundColor
        button.addTarget(self, action: #selector(buttonClick(button:)), for: UIControl.Event.touchUpInside)
        objc_setAssociatedObject(button, "ButtonBlockKey", block, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        clickBlock = block
        return button
    }

    @objc class func buttonClick(button : UIButton) {
        print("按钮的点击")
        clickBlock()
    }
}


extension UIButton {
    /*
     description : 设置图片和文字的按钮
     edgeStyle ：图左文右，图右文左，图上文下，图下文上
     space ： 图片和文字的间距
     */
    func setButtonWithEdgeInsetsStyle(edgeStyle : ButtonLayoutStyle ,space : CGFloat) {
        let imageWith = self.imageView!.image!.size.width;
        let imageHeight = self.imageView!.image!.size.height;
        var labelWidth : CGFloat  = 0.0;
        var labelHeight : CGFloat = 0.0;
        if #available(iOS 8.0, *) {
            labelWidth = self.titleLabel!.intrinsicContentSize.width;
            labelHeight = self.titleLabel!.intrinsicContentSize.height;
        } else {
            labelWidth = self.titleLabel!.frame.width;
            labelHeight = self.titleLabel!.frame.height;
        }
        var imageEdgeInsets = UIEdgeInsets.zero;
        var labelEdgeInsets = UIEdgeInsets.zero;
        switch (edgeStyle) {
            case .ButtonLayoutStyleImagePositionTop: do {
                    imageEdgeInsets = UIEdgeInsets.init(top: -labelHeight - space / 2.0, left: 0.0, bottom: 0.0, right: -labelWidth)
                    labelEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageWith, bottom: -imageHeight-space / 2.0, right: 0.0)
                }
                    break;
            case .ButtonLayoutStyleImagePositionLeft: do {
                   imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -space / 2.0, bottom: 0.0, right: space / 2.0)
                   labelEdgeInsets = UIEdgeInsets.init(top: 0, left: space / 2.0, bottom: 0.0, right: -space / 2.0)
                }
                    break;
            case .ButtonLayoutStyleImagePositionBottom: do {
                    imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: -labelHeight - space / 2.0, right:  -labelWidth)
                    labelEdgeInsets = UIEdgeInsets.init(top: -imageHeight - space / 2.0, left: -imageWith, bottom: 0.0, right: 0.0)
                }
                    break;
            case .ButtonLayoutStyleImagePositionRight: do {
                    imageEdgeInsets = UIEdgeInsets.init(top: 0, left: labelWidth + space / 2.0, bottom: 0.0, right: -labelWidth - space / 2.0)
                    labelEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageWith - space / 2.0, bottom: 0.0, right: imageWith + space / 2.0)
                }
                    break;
            default:
                break;
        }
        self.titleEdgeInsets = labelEdgeInsets;
        self.imageEdgeInsets = imageEdgeInsets;
    }
}
