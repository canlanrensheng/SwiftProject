//
//  CALayer+Extention.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/4/21.
//  Copyright © 2020 张金山. All rights reserved.
//

import Foundation

// MARK: - Sketch
public extension CALayer {
    
    ///  根据sketch参数，设置layer的阴影
    /// - Parameters:
    ///   - color: 阴影颜色
    ///   - alpha: 阴影alpha
    ///   - x: x轴偏移
    ///   - y: y轴偏移
    ///   - blur: 模糊度
    ///   - spread: 阴影扩展尺寸
    func setSketchShadow(color: UIColor, alpha: Float, x: CGFloat, y: CGFloat, blur: CGFloat, spread: CGFloat) {
        var rect = bounds
        if spread != 0 {
            rect = rect.insetBy(dx: -spread, dy: -spread)
        }
        let shadowPath = UIBezierPath(rect: rect)
        self.setSketchShadow(color: color, alpha: alpha, x: x, y: y, blur: blur, shadowPath: shadowPath)
    }
    
    ///  根据sketch参数，设置layer的阴影
    /// - Parameters:
    ///   - color: 阴影颜色
    ///   - alpha: 阴影alpha
    ///   - x: x轴偏移
    ///   - y: y轴偏移
    ///   - blur: 模糊度
    ///   - cornerRadius: 圆角
    func setSketchShadow(color: UIColor, alpha: Float, x: CGFloat, y: CGFloat, blur: CGFloat, cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        self.setSketchShadow(color: color, alpha: alpha, x:x, y: y, blur: blur, shadowPath: shadowPath)
    }
    
    ///  根据sketch参数，设置layer的阴影
    /// - Parameters:
    ///   - color: 阴影颜色
    ///   - alpha: 阴影alpha
    ///   - x: x轴偏移
    ///   - y: y轴偏移
    ///   - blur: 模糊度
    ///   - shadowPath: 自定义shadowPath
    func setSketchShadow(color: UIColor, alpha: Float, x: CGFloat, y: CGFloat, blur: CGFloat, shadowPath: UIBezierPath) {
        self.shadowColor = color.cgColor
        self.shadowOpacity = alpha
        self.shadowOffset = CGSize(width: x, height: y)
        self.shadowRadius = blur / 2.0
        self.shadowPath = shadowPath.cgPath
    }
    
}
