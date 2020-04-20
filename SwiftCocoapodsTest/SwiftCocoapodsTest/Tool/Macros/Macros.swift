//
//  Macros.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/2/26.
//  Copyright © 2020 张金山. All rights reserved.
//

import Foundation

//屏幕宽度
var KScreenWidth = UIScreen.main.bounds.size.width
//屏幕高度
var KScreenHeight = UIScreen.main.bounds.size.height

//宽度比例
let widthScale = KScreenWidth / 375.0

//是iPhone X
let iPhoneX = (KScreenWidth == 375.0 && KScreenHeight == 812.0)

//是iPhone XR
let iPhoneXR = (KScreenWidth == 414.0 && KScreenHeight == 896.0)

//全面屏手机
let isFullScreen = (iPhoneX || iPhoneXR)

//状态栏高度
let kStateBarHeight = isFullScreen ? 44.0 : 20.0

//导航条的高度
let kNavigationBarHeight = kStateBarHeight + 44.0

//底部tabbar的高度
let kTabBarHeight = (isFullScreen ? 83 : 49);

//判断是不是plus
let iphone6Plus =  (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1242, height: 2208).equalTo((UIScreen.main.currentMode?.size)!) : false)

//图片
func kImageName(_ name : String) -> UIImage {
    return UIImage.init(named: name)!
}

//Regular  字体
func RegularFont(_ size : CGFloat) -> UIFont {
    return UIFont.init(name: "PingFangSC-Regular", size: size)!
}

//Medium 字体
func MediumFont(_ size : CGFloat) -> UIFont {
    return UIFont.init(name: "PingFangSC-Medium", size: size)!
}

//RGB色值
func HexColor(_ rgbValue : NSInteger) -> UIColor {
    return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,alpha: 1.0)
}

//带RGBA的十六进制转UIColor
func HexColorAlpha(rgbValue : NSInteger,alpha : CGFloat) -> UIColor {
    return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,alpha: alpha)
}

//项目主题颜色
let MainColor = HexColor(0xDB1919)
//白色
let whiteColor = UIColor.white
//黑色
let blackColor = UIColor.black
//橙色
let orangeColor = UIColor.orange
//蓝色
let blueColor = UIColor.blue
//0x333333
let TextColor = HexColor(0x333333)
//0x999999
let lightTextColor = HexColor(0x999999)
//tableViewBackgroundColor
let tableViewBackGroundColor = HexColor(0xf5f5f5)


