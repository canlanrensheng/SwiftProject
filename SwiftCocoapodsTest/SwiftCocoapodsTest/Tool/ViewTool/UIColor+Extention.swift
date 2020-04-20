//
//  UIColor+Extention.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/4/20.
//  Copyright © 2020 张金山. All rights reserved.
//

import Foundation

extension UIColor {
    
    /// 颜色16进制字符串格式，例如："#DECEB5"
    var hexString: String {
        let components: [Int] = {
            let comps = cgColor.components!
            let components = comps.count == 4 ? comps : [comps[0], comps[0], comps[0], comps[1]]
            return components.map { Int($0 * 255.0) }
        }()
        return String(format: "#%02X%02X%02X", components[0], components[1], components[2])
    }
    
    /// 颜色UInt整数格式，例如：0xDECEB5
    var hex: UInt {
        let comps: [CGFloat] = {
            let comps = cgColor.components!
            return comps.count == 4 ? comps : [comps[0], comps[0], comps[0], comps[1]]
        }()
        
        var colorAsUInt32: UInt32 = 0
        colorAsUInt32 += UInt32(comps[0] * 255.0) << 16
        colorAsUInt32 += UInt32(comps[1] * 255.0) << 8
        colorAsUInt32 += UInt32(comps[2] * 255.0)
        return UInt(colorAsUInt32)
    }
    
    /// UInt整数创建字符串
    ///
    /// - Parameters:
    ///   - hex: UInt整数，例如：0xDECEB5
    ///   - alpha: alpha值
    convenience init(rgbHex hex: UInt, alpha: CGFloat = 1) {
        var trans = alpha
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        let red = (hex >> 16) & 0xff
        let green = (hex >> 8) & 0xff
        let blue = hex & 0xff
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    /// 16进制字符串创建颜色
    ///
    /// - Parameters:
    ///   - hexString: 16进制字符串 例如: EDE7F6, 0xEDE7F6, #EDE7F6, #0ff, 0xF0F
    ///   - alpha: alpha value (default is 1).
    convenience init?(rgbHexString hexString: String, alpha: CGFloat = 1) {
        var string = ""
        if hexString.lowercased().hasPrefix("0x") {
            string =  hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }
        
        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }
        
        guard let hexValue = UInt(string, radix: 16) else { return nil }
        self.init(rgbHex: hexValue, alpha: alpha)
    }
    
    /// 颜色的RGB值，0~1之间
    ///
    ///     UIColor.red.rgbComponents.red -> 1
    ///     UIColor.green.rgbComponents.green -> 1
    ///     UIColor.blue.rgbComponents.blue -> 1
    ///
    var rgbComponents: (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var components: [CGFloat] {
            let comps = cgColor.components!
            if comps.count == 4 { return comps }
            return [comps[0], comps[0], comps[0], comps[1]]
        }
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        return (red: red, green: green, blue: blue)
    }
    
}
