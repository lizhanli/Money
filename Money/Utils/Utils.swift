//
//  Utils.swift
//  unique
//
//  Created by 李占理 on 17/7/29.
//  Copyright © 2017年 李占理. All rights reserved.
//

import UIKit

class Utils: NSObject {

    //MARK: -isEmpty
    static func isEmpty(_ str: String?) -> Bool {
        return str == nil || "" == str?.trim()
    }
    
    static func isEmptyArray(_ array: Array<Any>?) -> Bool {
        return (array?.count ?? 0) == 0
    }
    
    static func isEmptyDictionary(_ dic: [String : Any]?) -> Bool {
        return (dic?.count ?? 0) == 0
    }

    
}
