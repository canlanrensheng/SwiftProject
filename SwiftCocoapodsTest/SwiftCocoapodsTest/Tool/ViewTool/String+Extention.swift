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
    var isEmpty : Bool {
        if self == "" || self == "(null)" || self.count == 0 {
            return false
        }
        return true
    }
    
    //是否是手机号码
    var validateMobile : Bool {
        let emailRegex = "^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    // 是否是邮箱
    var isValidEmail: Bool {
        // http://emailregex.com/
        let regex = "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    //是否是URL
    var validateUrl : Bool {
        let urlRegex = "((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
        return NSPredicate(format: "SELF MATCHES %@", urlRegex).evaluate(with: self)
    }
    
    //是否是数字
    var isNumeric: Bool {
        let scanner = Scanner(string: self)
        scanner.locale = NSLocale.current
        #if os(Linux)
        return scanner.scanDecimal() != nil && scanner.isAtEnd
        #else
        return scanner.scanDecimal(nil) && scanner.isAtEnd
        #endif
    }
    
    //是否是数字 不包含小数点
    var isDigits: Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }
    
    //获取字符串的长度
    var length : Int {
        return self.count
    }
    
    //获取int
    var intValue : Int {
        return Int(self)!
    }
    
    //获取float
    var floatValue : Float {
        return Float(self)!
    }
    
    //获取double
    var doubleValue : Double {
        return Double(self)!
    }
}

extension String {
   
    /// Readable string from a URL string.
    ///
    ///     "it's%20easy%20to%20decode%20strings".urlDecoded() -> "it's easy to decode strings"
    ///
    func urlDecoded() -> String {
        return removingPercentEncoding ?? self
    }
    
    /// URL escaped string.
    ///
    ///     "it's easy to encode strings".urlEncoded() -> "it's%20easy%20to%20encode%20strings"
    ///
    func urlEncoded() -> String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    /// 字符串转数组
    ///
    ///     "1.3".charactersArray -> ["1", ".", "3"]
    ///
    var charactersArray: [Character] {
        return Array(self)
    }
    
    /// 字符串反转
    ///
    ///
    ///
    /// - Returns: Reversed string
    func reversingString() -> String {
        let chars: [Character] = reversed()
        return String(chars)
    }
    
    //过滤掉所有换行、空格和Tab
    func removeAllSpaceAndNewline() ->String{
        var str = self.replacingOccurrences(of:" ", with:"")
        str = str.replacingOccurrences(of:" ", with:"")
        str = str.replacingOccurrences(of:"\r", with:"")
        str = str.replacingOccurrences(of:"\n", with:"")
        return str
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
    
    
    /// 把Foundation对象json化成一个字符串
    ///
    ///     String(fromJson: [1, 2]) == "[1,2]"
    ///
    /// - Parameter jsonObject: Foundation对象
    ///   For possible values, see `JSONSerialization.ReadingOptions`.
    init?(fromJson object: Any, options: JSONSerialization.WritingOptions = []) {
        guard JSONSerialization.isValidJSONObject(object) else { return nil }
        let data = try? JSONSerialization.data(withJSONObject: object, options: options)
        guard let anData = data else { return nil }
        self.init(bytes: anData, encoding: .utf8)
    }
    
    /// 把当前字符串解析成Foundation对象
    ///
    ///     "[1,2]".asJsonObject() as? Array == [1, 2]
    ///
    /// - Parameter options: Options for reading the JSON data and creating the Foundation object.
    ///
    ///   For possible values, see `JSONSerialization.ReadingOptions`.
    /// - Returns: A Foundation object from the JSON data in the receiver, or `nil` if an error occurs.
    /// - Throws: An `NSError` if the receiver does not represent a valid JSON object.
    func asJsonObject(options: JSONSerialization.ReadingOptions = []) -> Any? {
        guard let stringData = data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: stringData, options: options)
    }
    
    /// Check if string contains one or more emojis.
    ///
    ///     "Hello 😀".containEmoji -> true
    ///
    var containEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map
            0x1F1E6...0x1F1FF, // Regional country flags
            0x2600...0x26FF, // Misc symbols
            0x2700...0x27BF, // Dingbats
            0xE0020...0xE007F, // Tags
            0xFE00...0xFE0F, // Variation Selectors
            0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
            127000...127600, // Various asian characters
            65024...65039, // Variation selector
            9100...9300, // Misc items
            8400...8447: // Combining Diacritical Marks for Symbols
                return true
            default:
                continue
            }
        }
        return false
    }
    
}

// MARK: - Subscript
extension String {
    
    //往后截取字符串
    func subStringFrom(_ index:Int) -> String {
        return (self as NSString).substring(from: index)
    }
    
    //往前截取字符串
    func subStringTo(_ index:Int) -> String {
        return (self as NSString).substring(to: index)
    }
    
    
    /// Safely subscript string with index.
    ///
    ///     "Hello World!"[safe: 3] -> "l"
    ///     "Hello World!"[safe: 20] -> nil
    ///
    /// - Parameter index: index.
    subscript(safe index: Int) -> Character? {
        guard index >= 0 && index < count else { return nil }
        return self[self.index(startIndex, offsetBy: index)]
    }
    
    /// Safely subscript string within a half-open range.
    ///
    ///     "Hello World!"[safe: 6..<11] -> "World"
    ///     "Hello World!"[safe: 6..<100] -> "World!"
    ///     "Hello World!"[safe: 21..<110] -> nil
    ///
    /// - Parameter range: Half-open range.
    subscript(safe range: Range<Int>) -> String {
        guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex) else { return "" }
        guard let upperIndex = index(lowerIndex, offsetBy: min(range.upperBound, self.count) - range.lowerBound, limitedBy: endIndex) else { return "" }
        return String(self[lowerIndex..<upperIndex])
    }
    
    /// Safely subscript string within a closed range.
    ///
    ///     "Hello World!"[safe: 6...11] -> "World!"
    ///     "Hello World!"[safe: 6...100] -> "World!"
    ///     "Hello World!"[safe: 21...110] -> nil
    ///
    /// - Parameter range: Closed range.
    subscript(safe range: ClosedRange<Int>) -> String {
        let lowerBound = max(0, range.lowerBound)
        guard let lowerIndex = index(startIndex, offsetBy: lowerBound, limitedBy: endIndex) else { return "" }
        guard let upperIndex = index(lowerIndex, offsetBy: min(range.upperBound, self.count - 1) - lowerBound, limitedBy: endIndex) else { return "" }
        return String(self[lowerIndex...upperIndex])
    }
    
    /// Safely subscript string within a partial Range through.
    ///
    ///     "Hello World!"[safe: ...11] -> "Hello World"
    ///     "Hello World!"[safe: ...-1] -> "Hello World"
    ///     "Hello World!"[safe: ...100] -> "Hello World"
    ///
    /// - Parameter range: partial Range through
    subscript(safe range: PartialRangeThrough<Int>) -> String? {
        guard range.upperBound >= 0 else { return "" }
        return self[safe: 0...range.upperBound]
    }
    
    /// Safely subscript string within a partial Range from.
    ///
    ///     "Hello World!"[safe: 6..] -> "Hello World"
    ///     "Hello World!"[safe: 12...] -> "Hello World"
    ///     "Hello World!"[safe: -100...] -> "Hello World"
    ///
    /// - Parameter range: partial Range from
    subscript(safe range: PartialRangeFrom<Int>) -> String? {
        guard range.lowerBound <= count - 1 else { return "" }
        return self[safe: range.lowerBound...(count - 1)]
    }
    
    /// Safely subscript string within a partial Range up to.
    ///
    ///     "Hello World!"[safe: ..<11] -> "Hello World"
    ///     "Hello World!"[safe: ..<-1] -> "Hello World"
    ///     "Hello World!"[safe: ..<100] -> "Hello World"
    ///
    /// - Parameter range: partial Range up to
    subscript(safe range: PartialRangeUpTo<Int>) -> String? {
        guard range.upperBound > 0 else { return "" }
        return self[safe: 0..<range.upperBound]
    }
}

// MARK: - Compare
extension String {
    /// Compare with another version string.
    ///
    ///     compareVersion("1.1.1", "1.1.0") => .orderedDescending
    ///     compareVersion("1.1", "1.1.1") => .orderedAscending
    ///     compareVersion("1.0", "1.0.0") => .orderedSame
    ///     compareVersion("1.011.1", "1.11.1") => .orderedSame
    ///     compareVersion("3.11.1", "3.11.b") => .orderedAscending
    ///     compareVersion("3.11.1", "3.11.1b") => .orderedAscending
    ///     compareVersion("3.11.1", "3.2b.1") => .orderedDescending
    ///
    /// - Returns: compare result
    func compareVersion(_ version: String) -> ComparisonResult {
        let components1 = self.split(separator: ".")
        let components2 = version.split(separator: ".")
        
        let length = max(components1.count, components2.count)
        for index in 0..<length {
            let subVersion1 = (components1.count > index) ? components1[index] : "0"
            let subVersion2 = (components2.count > index) ? components2[index] : "0"
            
            let result = subVersion1.compare(subVersion2, options: .numeric)
            if (result != .orderedSame) {
                return result
            }
        }
        return .orderedSame
    }
}


// MARK: - Calculate
extension String {
    /// 计算文本占用大小
    /// - Parameters:
    ///   - font: 文本字体
    ///   - constainedSize: 限制大小
    func boundingRect(with font: UIFont, constainedSize: CGSize) -> CGRect {
        let rect = self.boundingRect(with: constainedSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return rect
    }
    
    /// 计算文本高度
    /// - Parameters:
    ///   - attributes: 文本属性
    ///   - constrainedWidth: 限制宽度
    func height(with attributes: [NSAttributedString.Key: Any], constrainedWidth: CGFloat) -> CGFloat {
        guard count > 0 && constrainedWidth > 0 else { return 0 }
        
        let size = CGSize(width: constrainedWidth, height: CGFloat.greatestFiniteMagnitude)
        let rect = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return rect.size.height
    }
    
    /// 计算文本高度
    /// - Parameters:
    ///   - font: 文本字体
    ///   - constrainedWidth: 限制宽度
    func height(with font: UIFont, constrainedWidth : CGFloat) -> CGFloat {
        guard count > 0 && constrainedWidth > 0 else { return 0 }
        
        let size = CGSize(width: constrainedWidth, height: CGFloat.greatestFiniteMagnitude)
        let rect = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return rect.size.height
    }
    
    /// 计算文本宽度
    /// - Parameter attributes: 文本属性
    func width(with attributes: [NSAttributedString.Key: Any]) -> CGFloat {
        guard count > 0 else { return 0 }
        
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0)
        let rect = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return rect.size.width
    }
    
    /// 计算文本宽度
    /// - Parameter font: 文本字体
    func width(with font: UIFont) -> CGFloat {
        guard count > 0 else { return 0 }
        
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0)
        let rect = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return rect.size.width
    }
}
