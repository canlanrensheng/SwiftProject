
//
//  JSLabel.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/2/29.
//  Copyright © 2020 张金山. All rights reserved.
//

import UIKit

class JSLabel: UILabel {
    
    /*
    description :创建Label
    textColor : textColor
    textAlignment : textAlignment
    font : font
    */
    class func createLabel(textColor : UIColor,textAlignment : NSTextAlignment,font : UIFont) -> UILabel {
        return createLabel(frame:CGRect(x: 0, y: 0, width: 0, height: 0), text: "", textColor: textColor, textAlignment: textAlignment, font: font, backgroundColor: UIColor.clear)
    }
    
    /*
    description :创建Label
    text  ： text
    textColor : textColor
    textAlignment : textAlignment
    font : font
    backgroundColor : backgroundColor
    */
    class func createLabel(text : String,textColor : UIColor,textAlignment : NSTextAlignment,font : UIFont,backgroundColor : UIColor) -> UILabel {
        return createLabel(frame:CGRect(x: 0, y: 0, width: 0, height: 0), text: text, textColor: textColor, textAlignment: textAlignment, font: font, backgroundColor: backgroundColor)
    }
    
    /*
     description :创建Label
     frame ： frame
     text  ： text
     textColor : textColor
     textAlignment : textAlignment
     font : font
     backgroundColor : backgroundColor
     */
    class func createLabel(frame :CGRect,text : String,textColor : UIColor,textAlignment : NSTextAlignment,font : UIFont,backgroundColor : UIColor) -> UILabel {
        let label = UILabel()
        label.frame = frame
        label.text = text
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.font = font
        label.backgroundColor = backgroundColor
        return label
    }
}

