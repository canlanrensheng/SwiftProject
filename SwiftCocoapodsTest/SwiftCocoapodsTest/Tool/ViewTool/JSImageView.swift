//
//  JSImageView.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/2/29.
//  Copyright © 2020 张金山. All rights reserved.
//

import UIKit

class JSImageView: UIImageView {
    
    class func createImageView(imageName : String) -> UIImageView {
        return createImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), imageName: imageName, backgroundColor: UIColor.clear)
    }
    
    class func createImageView(imageName : String,backgroundColor : UIColor) -> UIImageView {
        return createImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), imageName: imageName, backgroundColor: backgroundColor)
    }
  
    class func createImageView(frame : CGRect,imageName : String,backgroundColor : UIColor) -> UIImageView {
        let imageView = UIImageView.init()
        imageView.backgroundColor = backgroundColor
        imageView.image = UIImage(named: imageName)
        return imageView
    }
   
}
