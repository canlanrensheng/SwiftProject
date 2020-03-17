//
//  JSTextField.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/3/14.
//  Copyright © 2020 张金山. All rights reserved.
//

import UIKit

//typealias textFeildChageBlock = (_ text : String) -> ()

var textChageBlock : (_ text : String) -> ()  = {(text : String) in }

class JSTextField: UIView,UITextFieldDelegate {
    
    /*
    placeHoder : placeHoder
    placeHoderColor : placeHoderColor
    backgroundColor : backgroundColor
    */
    func createtextFeild(placeHoder : String,placeHoderColor : UIColor,backgroundColor : UIColor,block : @escaping (_ text : String)->()) -> UITextField {
      let textFeild = UITextField.init()
      textFeild.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
      textFeild.delegate = self
      textFeild.placeholder = placeHoder;
      textFeild.backgroundColor = backgroundColor
      textFeild.attributedPlaceholder = NSAttributedString.init(string: placeHoder, attributes: [NSMutableAttributedString.Key.foregroundColor : placeHoderColor])
      textChageBlock = block
      return textFeild
    }
    

    /*
     frame : frame
     placeHoder : placeHoder
     placeHoderColor : placeHoderColor
     backgroundColor : backgroundColor
     leftWidth : leftWidth
     */
    func createtextFeild( frame : CGRect, placeHoder : String,placeHoderColor : UIColor,backgroundColor : UIColor,leftWidth : CGFloat,block : @escaping (_ text : String)->()) -> UITextField {
        let textFeild = UITextField.init()
        textFeild.frame = frame
        textFeild.delegate = self
        textFeild.placeholder = placeHoder;
        textFeild.backgroundColor = backgroundColor
        textFeild.attributedPlaceholder = NSAttributedString.init(string: placeHoder, attributes: [NSMutableAttributedString.Key.foregroundColor : placeHoderColor])
        var frame = textFeild.frame
        frame.size.width = leftWidth
        let leftView = UIView.init(frame: frame)
        textFeild.leftViewMode = UITextField.ViewMode.always
        textFeild.leftView = leftView
        textFeild.addTarget(self, action: #selector(textValueChange(textField:)), for: UIControl.Event.editingChanged)
        textChageBlock = block
        return textFeild
    }
    
    @objc func textValueChange(textField : UITextField) {
        print("改变：")
        textChageBlock(textField.text!)
    }
}
