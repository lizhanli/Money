//
//  ExtensionArray.swift
//  unique
//
//  Created by 李占理 on 17/7/29.
//  Copyright © 2017年 李占理. All rights reserved.
//

import UIKit

extension Array {
    
    func toString(format: Bool) -> String {
        var str = "["
        for i in 0 ..< self.count {
            if let d = self[i] as? DictionaryDefault {
                if format {
                    str += d.toString()
                }else {
                    str += d.toStringNoFormat()
                }
            }else {
                str += "\(self[i])"
            }
            if i < self.count - 1 {
                str += ","
            }
        }
        str += "]"
        return str
    }
    
    func toString() -> String {
        return toString(format: true)
    }
    
    func toStringNoFormat() -> String {
        return toString(format: false)
    }
}
extension Array{
    //选择排序（选择最小元素）
    mutating func selectSort() {
//        var array = [12,54,76,1,23,23,6]
        [54,12,76]
        for i in 0..<self.count {
            var min = i
            for j in i+1..<self.count {
                if (self[j] as! Int) >= (self[min] as! Int){
                    min = j
                }
            }
            (self[min],self[i]) = (self[i],self[min])
        }
    }
}
