//
//  UIView+Extention.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/4/18.
//  Copyright © 2020 张金山. All rights reserved.
//

import Foundation

extension UIView {
    // 扩展 x 的 set get 方法
    var x: CGFloat{
        get{
            return frame.origin.x
        }
        set(newX){
            var tmpFrame: CGRect = frame
            tmpFrame.origin.x = newX
            frame = tmpFrame
        }
    }
    
    // 扩展 y 的 set get 方法
    var y: CGFloat{
        get{
            return frame.origin.y
        }
        set(newY){
            var tmpFrame: CGRect = frame
            tmpFrame.origin.y = newY
            frame = tmpFrame
        }
    }
    
    // 扩展 width 的 set get 方法
    var width: CGFloat{
        get{
            return frame.size.width
        }
        set(newWidth){
            var tmpFrameWidth: CGRect = frame
            tmpFrameWidth.size.width = newWidth
            frame = tmpFrameWidth
        }
    }
    
    // 扩展 height 的 set get 方法
    var height: CGFloat{
        get{
            return frame.size.height
        }
        set(newHeight){
            var tmpFrameHeight: CGRect = frame
            tmpFrameHeight.size.height = newHeight
            frame = tmpFrameHeight
        }
    }
    
    // 扩展 centerX 的 set get 方法
    var centerX: CGFloat{
        get{
            return center.x
        }
        set(newCenterX){
            center = CGPoint(x: newCenterX, y: center.y)
        }
    }
    
    // 扩展 centerY 的 set get 方法
    var centerY: CGFloat{
        get{
            return center.y
        }
        set(newCenterY){
            center = CGPoint(x: center.x, y: newCenterY)
        }
    }
    
    // 扩展 origin 的 set get 方法
    var origin: CGPoint{
        get{
            return CGPoint(x: x, y: y)
        }
        set(newOrigin){
            x = newOrigin.x
            y = newOrigin.y
        }
    }
    
    // 扩展 size 的 set get 方法
    var size: CGSize{
        get{
            return CGSize(width: width, height: height)
        }
        set(newSize){
            width = newSize.width
            height = newSize.height
        }
    }
    
    // 扩展 left 的 set get 方法
    var left: CGFloat{
        get{
            return x
        }
        set(newLeft){
            x = newLeft
        }
    }
    
    // 扩展 right 的 set get 方法
    var right: CGFloat{
        get{
            return x + width
        }
        set(newNight){
            x = newNight - width
        }
    }
    
    // 扩展 top 的 set get 方法
    var top: CGFloat{
        get{
            return y
        }
        set(newTop){
            y = newTop
        }
    }
    
    // 扩展 bottom 的 set get 方法
    var bottom: CGFloat{
        get{
            return  y + height
        }
        set(newBottom){
            y = newBottom - height
        }
    }
    
    //获取view所在的控制器
    func currentViewController() -> UIViewController? {
        //1.通过响应者链关系，取得此视图的下一个响应者
        var n = next
        while n != nil {
            //2.判断响应者对象是否是视图控制器类型
            if n is UIViewController {
                //3.转换类型后 返回
                return n as? UIViewController
            }
            n = n?.next
        }
        return nil
    }

    //切圆角
    func clipWithCorner(cornerRadius : CGFloat,borderColor : UIColor,borderWidth : CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    //创建视图
    func createView(backGroundColor : UIColor) -> UIView {
        let view : UIView = UIView.init()
        view.backgroundColor = backgroundColor
        return view
    }
    
    /**
     *  设置部分圆角(绝对布局)
     *
     *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
     *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
     */
    func addRoundedCorners(corners : UIRectCorner, radii : CGSize) {
        let rounded : UIBezierPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: radii)
        let shape : CAShapeLayer = CAShapeLayer.init()
        shape.path = rounded.cgPath
        self.layer.mask = shape
    }
    
    /**
     *  设置部分圆角(相对布局)
     *
     *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
     *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
     *  @param rect    需要设置的圆角view的rect
     */
    func addRoundedCorners(corners : UIRectCorner, radii : CGSize,rect : CGRect){
        let rounded : UIBezierPath = UIBezierPath.init(roundedRect:rect, byRoundingCorners: corners, cornerRadii: radii)
        let shape : CAShapeLayer = CAShapeLayer.init()
        shape.path = rounded.cgPath
        self.layer.mask = shape
    }
    
    //添加shadow
    
    func addShadow(toView : UIView,color : UIColor) {
        toView.layer.shadowColor = color.cgColor;
        toView.layer.shadowOffset = CGSize(width: 0, height: -1);
        toView.layer.shadowOpacity = 1;
        toView.layer.shadowRadius = 5;
        let shadowPathWidth : CGFloat = toView.layer.shadowRadius;
        let shadowRect : CGRect = CGRect(x: 0, y: 0 - shadowPathWidth / 2.0, width: toView.bounds.size.width, height: shadowPathWidth)
        let path : UIBezierPath = UIBezierPath.init(rect: shadowRect)
        toView.layer.shadowPath = path.cgPath;
    }

}
