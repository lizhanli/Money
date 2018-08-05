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
    
    func getCurrentViewController() ->UIViewController?{
        //app默认windowLevel是UIWindowLevelNormal，如果不是，找到它
        var resultVC:UIViewController? = nil
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindowLevelNormal {
            let windows = UIApplication.shared.windows
            for item in windows{
                if item.windowLevel == UIWindowLevelNormal{
                    window = item
                    break
                }
            }
        }
        var nextResponder:UIResponder? = nil
        let appRootVC = window?.rootViewController
        //1、通过present弹出VC，appRootVC.presentedViewController不为nil
        if appRootVC?.presentedViewController != nil{
            nextResponder = appRootVC?.presentedViewController
        }else{
            //2、通过navigationcontroller弹出VC
            let frontView = window?.subviews.first
            nextResponder = frontView?.next
        }
        //1、tabBarController
        if nextResponder?.isKind(of: UITabBarController.self) == true {
            let tabbar = nextResponder as? UITabBarController
            let nav = tabbar?.selectedViewController
            resultVC = nav?.childViewControllers.last
        }else if nextResponder?.isKind(of: UINavigationController.self) == true{
            //2、navigationController
            let nav = nextResponder as? UIViewController
            resultVC = nav?.childViewControllers.last
        }else{
            resultVC = nextResponder as? UIViewController
        }
        return resultVC
    }
    
}
