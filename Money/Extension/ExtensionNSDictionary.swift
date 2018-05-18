//
//  ExtensionNSDictionary.swift
//  YHGlobal
//
//  Created by Milo on 15/12/30.
//  Copyright © 2015年 YHFund. All rights reserved.
//

import Foundation

extension NSDictionary {
    
    func arrayForKey(_ key: String)->NSArray?{
        let value = self.object(forKey: key)
        return value as? NSArray
    }

    func stringForKey(_ key: String)->String?{
        let value = self.object(forKey: key)
        return value as? String
    }
    
    func nsStringForKey(_ key: String)->NSString?{
        let value = self.object(forKey: key)
        return value as? NSString
    }

    func numberForKey(_ key: String)-> NSNumber?{
        let value = self.object(forKey: key)
        return value as? NSNumber
    }
    
    func intForKey(_ key: String)->NSInteger?{
        let number = numberForKey(key)
        if(number != nil){
            return number?.intValue
        }
        return nil
    }
    
    func floatForKey(_ key: String)->Float?{
        let number = numberForKey(key)
        if(number != nil){
            return number?.floatValue
        }
        return nil
    }
    
    func doubleForKey(_ key: String)->Double?{
        let number = numberForKey(key)
        if(number != nil){
            return number?.doubleValue
        }
        return nil
    }
    
    func boolForKey(_ key: String)->Bool?{
        let number = numberForKey(key)
        if(number != nil){
            return number?.boolValue
        }
        return nil
    }
}

extension NSDictionary {
    
    open override var debugDescription: String {
        var string = ""
        string.append("{\\n")
        self.enumerateKeysAndObjects({ (key, value, stop) in
            string.append("\\t\(key)")
            string.append(": \(value),\\n")
        })
        string.append("}")
        return string
    }
}


