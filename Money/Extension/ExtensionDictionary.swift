//
//  ExtensionDictionary.swift
//  unique
//
//  Created by 李占理 on 17/7/29.
//  Copyright © 2017年 李占理. All rights reserved.
//

import UIKit

extension Dictionary{
   
    func valueForKey<T>(_ key:String) -> T? {
        return self[key as! Key] as? T
    }
    
    func arrayForKey(_ key:String) -> Array<Any>? {
        let value = self[key as! Key]
        return value as? Array<Any>
    }
    
    func dictionaryForKey(_ key: String) -> Dictionary<String, Any>? {
        let value = self[key as! Key]
        return value as? Dictionary<String, Any>
    }
    
    func arrayDictionaryForKey(_ key: String) -> Array<Dictionary<String, Any>>? {
        let value = self[key as! Key]
        return value as? Array<Dictionary<String, Any>>
    }
    
    func stringForKey(_ key: String) -> String? {
        let value = self[key as! Key]
        if value == nil {
            return nil
        }
        return (value! as? String)?.trim() ?? String(describing: value!).trim()
    }
    
    func stringForKey(_ key: String, defaultValue: String) -> String {
        return stringForKey(key) ?? defaultValue
    }
    
    func stringForKeyOrZero(_ key: String) -> String {
        return stringForKey(key, defaultValue: "0")
    }
    
    func stringForKeyOrNull(_ key: String) -> String {
        return stringForKey(key, defaultValue: "--")
    }

    func numberForKey(_ key: String) -> NSNumber? {
        let value = self[key as! Key]
        return value as? NSNumber
    }
    
    func intForKey(_ key: String) -> Int? {
        let number = numberForKey(key)
        if number != nil {
            return number?.intValue
        }else if let str = stringForKey(key){
            return NSString(string: str).integerValue
        }
        return nil
    }
    
    func intForKey(_ key: String, defaultValue: Int) -> Int {
        return intForKey(key) ?? defaultValue
    }
    
    func intForKeyOrZero(_ key: String) -> Int {
        return intForKey(key, defaultValue: 0)
    }
    
    func floatForKey(_ key: String) -> Float? {
        let number = numberForKey(key)
        if(number != nil){
            return number?.floatValue
        }else if let str = stringForKey(key){
            return NSString(string: str).floatValue
        }
        return nil
    }
    
    func floatForKey(_ key: String, defaultValue: Float) -> Float {
        return floatForKey(key) ?? defaultValue
    }
    
    func floatForKeyOrZero(_ key: String) -> Float {
        return floatForKey(key, defaultValue: 0)
    }
    
    func doubleForKey(_ key: String) -> Double? {
        let number = numberForKey(key)
        if(number != nil){
            return number?.doubleValue
        }else if let str = stringForKey(key){
            return NSString(string: str).doubleValue
        }
        return nil
    }
    
    func doubleForKey(_ key: String, defaultValue: Double) -> Double {
        return doubleForKey(key) ?? defaultValue
    }
    
    func doubleForKeyOrZero(_ key: String) -> Double {
        return doubleForKey(key, defaultValue: 0)
    }
    
    func boolForKey(_ key: String) -> Bool? {
        let number = numberForKey(key)
        if(number != nil){
            return number?.boolValue
        }
        return nil
    }
    
    func toString() -> String {
        return toStringWithFormat(JSONSerialization.WritingOptions.prettyPrinted)
    }
    
    func toStringNoFormat() -> String {
        return toStringWithFormat(JSONSerialization.WritingOptions.init(rawValue: 0))
    }
    
    func toStringWithFormat(_ options: JSONSerialization.WritingOptions) -> String {
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options) {
            if let result = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
                result.replacingOccurrences(of: "\n", with: "")
                result.replacingOccurrences(of: "\t", with: "")
                return result as String
            }
        }
        return ""
    }

    mutating func merge(_ dic: DictionaryDefault?) {
        dic?.forEach({ (item) in
            if let value = item.1 as? Value {
                self.updateValue(value, forKey: item.0 as! Key)
            }
        })
    }
    
    mutating func merge(_ dic: DictionaryDefault?, without keys: [String]) {
        dic?.forEach({ (item) in
            if !keys.contains(item.0) {
                if let value = item.1 as? Value {
                    self.updateValue(value, forKey: item.0 as! Key)
                }
            }
        })
    }
    
    mutating func merge(_ dic: DictionaryDefault?, keys: [String]) {
        if dic == nil {
            return
        }
        for key in keys {
            if let value = dic![key] as? Value {
                self.updateValue (value, forKey: key as! Key)
            }
        }
    }
}
