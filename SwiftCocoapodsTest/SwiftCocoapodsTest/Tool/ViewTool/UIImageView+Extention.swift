//
//  UIImageView+Extention.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/4/18.
//  Copyright © 2020 张金山. All rights reserved.
//

import Foundation

extension UIImageView {
    /*
     imageName : imageName
     */
    class func createImageView(imageName : String) -> UIImageView {
        return createImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), imageName: imageName, backgroundColor: UIColor.clear)
    }
    
    /*
     imageName : imageName
     backGroundColor : backGroundColor
     */
    class func createImageView(imageName : String,backgroundColor : UIColor) -> UIImageView {
        return createImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), imageName: imageName, backgroundColor: backgroundColor)
    }
    
    /*
     frame : frame
     imageName : imageName
     backGroundColor : backGroundColor
     */
    class func createImageView(frame : CGRect,imageName : String,backgroundColor : UIColor) -> UIImageView {
        let imageView = UIImageView.init()
        imageView.backgroundColor = backgroundColor
        imageView.image = UIImage(named: imageName)
        return imageView
    }
}
