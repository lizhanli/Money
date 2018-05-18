//
//  ExtensionUIButton.swift
//  unique
//
//  Created by 李占理 on 17/7/30.
//  Copyright © 2017年 李占理. All rights reserved.
//

import UIKit

extension UIButton{
    
    //实现控制button的重复点击
//    open override class func initialize(){
//        DispatchQueue.synchronized(lock: self) {
//            let originalMethod = #selector(UIButton.sendAction(_:to:for:))
//            let myMethod = #selector(UIButton.myButton(_:to:for:))
//
//            let original = class_getInstanceMethod(self, originalMethod)
//            let mine = class_getInstanceMethod(self, myMethod)
//
//            let didAddMethod = class_addMethod(self, originalMethod, method_getImplementation(mine!), method_getTypeEncoding(mine!))
//            if didAddMethod{
//               class_replaceMethod(self, myMethod,method_getImplementation(original!), method_getTypeEncoding(original!))
//            }else{
//               method_exchangeImplementations(original!, mine!)
//            }
//        }
//    }
//
//    @objc func myButton(_ action: Selector, to target: Any?, for event: UIEvent?){
//        //可以设置tag值来实现哪些button需要控制重复点击
//        struct Once{
//            static var loopSwitch:Dictionary<String,String> = [:]
//        }
//        if Once.loopSwitch[action.description] != "false" {
//             _ = (target as AnyObject).perform(action, with: self)
//            Once.loopSwitch[action.description] = "false"
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
//                Once.loopSwitch[action.description] = "true"
//            })
//        }
//    }
}

extension DispatchQueue{
    static func synchronized(lock:AnyObject,closure:()->()){
        objc_sync_enter(lock)
        closure()
        objc_sync_exit(lock)
    }
}
