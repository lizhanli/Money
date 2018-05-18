//
//  Public.swift
//  Money
//
//  Created by 李占理 on 2018/5/17.
//  Copyright © 2018年 Marsli. All rights reserved.
//

import UIKit

let Debug = true
private let LogFlag: String = "=========="
var DebugLog: Bool {
    return Debug && true
}

let ZLScreenWidth = UIScreen.main.bounds.size.width
let ZLScreenHeight = UIScreen.main.bounds.size.height

typealias DictionaryDefault = Dictionary<String, Any>
typealias SimpleCallBackData = (_ data:Dictionary<String,Any>) ->Void
typealias SimpleCallBackAny = (_ objc:Any) ->Void
typealias SimpleCallBack = () ->Void

func logInfo(_ value: String, file: String = #file, line: Int = #line){
    if (DebugLog) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"
        dateFormatter.locale = Locale.current
        print("\(dateFormatter.string(from: Date())) [\(URL.init(fileURLWithPath: file).lastPathComponent):\(line)] \(value)")
    }
}

func logFlag(_ file: String = #file, funcName: String = #function, line: Int = #line) {
    if (DebugLog) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"
        dateFormatter.locale = Locale.current
        print(dateFormatter.string(from: Date()), LogFlag, "[\(URL.init(fileURLWithPath: file).lastPathComponent):\(line)] -> \(funcName)",LogFlag)
    }
}


let PI = CGFloat(M_PI)
let PI2 = CGFloat(M_PI * 2)
let PI_2 = CGFloat(M_PI * 0.5)

