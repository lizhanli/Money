//
//  ExtensionString.swift
//  unique
//
//  Created by 李占理 on 17/7/29.
//  Copyright © 2017年 李占理. All rights reserved.
//

import UIKit
import Foundation

extension String{

    func toInt() -> Int? {
        return Int(self)
    }
    
    func toFloat() -> Float? {
        return Float(self)
    }
    
    func toDouble() -> Double? {
        return Double(self)
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    func length() -> Int {
        return self.characters.count
    }
    
    func indexOf(_ target: String)->Int {
        let range = self.range(of: target)
        if  range != nil{
            return self.substring(to: (range?.lowerBound)!).characters.count
        }
        return -1
    }
    
    func subString(to: Int) -> String {
        return self.substring(to: self.characters.index(self.startIndex, offsetBy: to))
    }
    
    func subString(from: Int) -> String {
        return self.substring(from: self.characters.index(self.startIndex, offsetBy: from))
    }
    
    func subString(start: Int, end: Int) -> String {
        let aRange = self.characters.index(self.startIndex, offsetBy: start) ..< self.characters.index(self.startIndex, offsetBy: end)
        return self.substring(with: aRange)
    }
    
    func subString(range: NSRange) -> String {
        let aRange = self.characters.index(self.startIndex, offsetBy: range.location) ..< self.characters.index(self.startIndex, offsetBy: range.location + range.length)
        return self.substring(with: aRange)
    }
}
extension String{
   
    func labelHeight(size: CGFloat, width: CGFloat) -> CGFloat {
        return labelHeight(font: UIFont.systemFont(ofSize: size), width: width)
    }
    
    func labelHeight(font: UIFont, width: CGFloat) -> CGFloat {
        let size = CGSize(width: width,height: CGFloat.greatestFiniteMagnitude)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        let attributes = [NSAttributedStringKey.font:font, NSAttributedStringKey.paragraphStyle:paragraphStyle.copy()]
        
        let text = self as NSString
        
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        return rect.size.height
    }
    
    func labelHeight(size: CGFloat, width: CGFloat,lineSpacing: CGFloat) -> CGFloat {
        return labelHeight(font: UIFont.systemFont(ofSize: size), width: width, lineSpacing: lineSpacing)
    }
    
    func labelHeight(font: UIFont, width: CGFloat,lineSpacing:CGFloat) -> CGFloat {
        let size = CGSize(width: width,height: CGFloat.greatestFiniteMagnitude)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        let attributes = [NSAttributedStringKey.font:font, NSAttributedStringKey.paragraphStyle:paragraphStyle.copy()]
        let text = self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        return rect.size.height
    }
    
    func labelWidth(size: CGFloat, Height: CGFloat) -> CGFloat {
        return labelWidth(font: UIFont.systemFont(ofSize: size), Height: Height)
    }
    
    func labelWidth(font: UIFont, Height: CGFloat) -> CGFloat {
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude,height: Height)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        let attributes = [NSAttributedStringKey.font:font, NSAttributedStringKey.paragraphStyle:paragraphStyle.copy()]
        let text = self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        return rect.size.width
    }
}

extension String{
    
    func toMD5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deallocate(capacity: digestLen)
        return String(format: hash as String)
    }
    
    func toBase64Encode() -> String! {
        // 将字符串进行UTF8编码成NSData
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: true)
        // 将NSData进行base64编码
        let base64Str = data?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64Str
    }
    
    func toBase64Decode() -> String! {
        // 将base64字符串转换成NSData
        let data = Data(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0))
        // 对NSData数据进行UTF8解码
        let str = String(data: data!, encoding: String.Encoding.utf8)
        return str
    }
    
    //MARK:- URL编码/解码
    func toUrlEncode() -> String? {
        let result = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)
        return (result?.replacingOccurrences(of: " ", with: "+"))
    }
    
    func toUrlDecode() -> String? {
        let result = self.replacingOccurrences(of: "+", with: " ")
        return result.removingPercentEncoding
    }
    
    func toDictionary() -> DictionaryDefault? {
        if let data = self.data(using: String.Encoding.utf8) {
            let dic = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            return dic as? DictionaryDefault
        }
        return nil
    }
    
    static func URLEncode(_ url: String) -> String {
        if !url.contains("?") {
            return url
        }
        var url = url
        let array = url.components(separatedBy: "?").last!.components(separatedBy: "&")
        for str in array {
            let param = str.components(separatedBy: "=")
            if param.count > 1 && !Utils.isEmpty(param[1]) {
                url = url.replacingOccurrences(of: param[1], with: param[1].toUrlEncode() ?? "")
            }
        }
        return url
    }
    
    //编码
    func encodeEscapesURL() -> String {
        let str:NSString = self as NSString
        let originalString = str as CFString
        let charactersToBeEscaped = "!*'();:@&=+$,/?%#[]" as CFString  //":/?&=;+!@#$()',*"    //转意符号
        //let charactersToLeaveUnescaped = "[]." as CFStringRef  //保留的符号
        let result =
            CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,originalString,nil,    //charactersToLeaveUnescaped,
                charactersToBeEscaped,
                CFStringConvertNSStringEncodingToEncoding(String.Encoding.utf8.rawValue)) as NSString
        return result as String
    }
    
    func encodeURL() -> String{
        return (self as NSString).addingPercentEscapes(using: String.Encoding.utf8.rawValue)!
    }
    
    /*
     *去掉所有空格
     */
    func removeAllSapce() ->String{
        return self.replacingOccurrences(of:" ", with: "", options: String.CompareOptions.literal, range: nil)
    }
}
