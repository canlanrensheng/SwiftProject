//
//  String+Extention.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/4/18.
//  Copyright © 2020 张金山. All rights reserved.
//

import Foundation

extension String {
    //字符串判断空
    func isEmpty() -> Bool {
        if self == "" || self == "(null)" || self.count == 0 {
            return false
        }
        return true
    }
    
    //过滤掉所有换行、空格和Tab
    func removeAllSpaceAndNewline() ->String{
        var str = self.replacingOccurrences(of:" ", with:"")
        str = str.replacingOccurrences(of:" ", with:"")
        str = str.replacingOccurrences(of:"\r", with:"")
        str = str.replacingOccurrences(of:"\n", with:"")
        return str
    }
    
    //是否是手机号码
    func validateMobile() -> Bool {
        let emailRegex = "^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    // 是否是邮箱
    func validateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    //是否是URL
    func validateUrl() -> Bool {
        let urlRegex = "((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
        return NSPredicate(format: "SELF MATCHES %@", urlRegex).evaluate(with: self)
    }
    
    /// 判断是否含有某个字符串
    func contains(find: String) -> Bool {
        return self.range(of: find) != nil
    }
    
    /// 判断是否含有某个字符串 忽略大小写
    func containsIgnoringCase(find: String) -> Bool {
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    /// 根据字符串计算高度尺寸，width 默认是最大数
    func size(font: UIFont, width: CGFloat = CGFloat.greatestFiniteMagnitude, paragraphStyle: NSParagraphStyle = NSParagraphStyle.default) -> CGSize {
        var attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font : font]
        attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        let rect = self.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
                                     options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                     attributes: attributes,
                                     context: nil)
        return rect.size
    }
    
    /// 根据字符串计算宽度尺寸
    func getSizeWithHeight(font: UIFont, height: CGFloat = CGFloat.greatestFiniteMagnitude, paragraphStyle: NSParagraphStyle = NSParagraphStyle.default) -> CGSize {
        var attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font : font]
        attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        let rect = self.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height),
                                     options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                     attributes: attributes,
                                     context: nil)
        return rect.size
    }
    
    //往后截取字符串
    func subStringFrom(_ index:Int) -> String {
        return (self as NSString).substring(from: index)
    }

    //往前截取字符串
    func subStringTo(_ index:Int) -> String {
        return (self as NSString).substring(to: index)
    }
    
    //获取字符串的长度
    func length() -> Int {
        return self.count
    }
    
    
    //JSONString转换为字典
    func getDictionaryFromJSONString(jsonString : String) ->NSDictionary{
        let jsonData:Data = jsonString.data(using: .utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    
    /**
     字典转换为JSONString
     
     - parameter dictionary: 字典参数
     
     - returns: JSONString
     */
    func getJSONStringFromDictionary(dictionary : NSDictionary) -> String {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData?
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
    
    //富文本
    func fuWenBenWithStr(str : String,color : UIColor,font : UIFont) -> NSAttributedString {
        let range : NSRange  = NSRange.init(str)!
        let newStr : NSMutableAttributedString = NSMutableAttributedString.init(string: self)
        newStr.addAttributes([NSAttributedString.Key.foregroundColor : color] , range: range)
        newStr.addAttributes([NSAttributedString.Key.font : font], range: range)
        return newStr
    }
    
    //富文本
    func fuWenBenWithStr(str : String,color : UIColor,font : UIFont,space:CGFloat) -> NSAttributedString {
        let range : NSRange  = NSRange.init(str)!
        let newStr : NSMutableAttributedString = NSMutableAttributedString.init(string: self)
        let paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = space
        newStr.addAttributes([NSAttributedString.Key.paragraphStyle : paragraphStyle ], range: range)
        newStr.addAttributes([NSAttributedString.Key.foregroundColor : color] , range: range)
        newStr.addAttributes([NSAttributedString.Key.font : font], range: range)
        return newStr
    }
    
    //计算文本的高度
    func getTextHeight(textWidth: CGFloat,lineSpace : CGFloat,font : UIFont) -> CGFloat {
        let maxSize = CGSize(width: textWidth, height: CGFloat(MAXFLOAT))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .justified
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.lineSpacing = lineSpace
        let labelSize = NSString(string: self).boundingRect(with: maxSize,
                                                            options: [.usesFontLeading, .usesLineFragmentOrigin],
                                                            attributes:[.font : font, .paragraphStyle: paragraphStyle],
                                                            context: nil).size
        return labelSize.height
    }
    
    //获取文本的宽度
    func getTextWidth(font : UIFont, height: CGFloat) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    //获取int
    func intValue() -> Int {
        return Int(self)!
    }
    
    //获取float
    func floatValue() -> Float {
        return Float(self)!
    }
    
    //获取double
    func doubleValue() -> Double {
        return Double(self)!
    }
}
