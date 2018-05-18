//
//  ExtensionUIViewController.swift
//  unique
//
//  Created by 李占理 on 17/7/29.
//  Copyright © 2017年 李占理. All rights reserved.
//

import UIKit

extension UIViewController{
    
    var zl_heightStatusBar:CGFloat{
       return UIApplication.shared.statusBarFrame.size.height
    }
    
    var zl_heightNavBar:CGFloat{
        if self.navigationController?.navigationBar.isHidden == false {
            return self.navigationController!.navigationBar.frame.size.height
        }
        return 0
    }
    var zl_heightTabBar:CGFloat{
        if !self.hidesBottomBarWhenPushed && self.tabBarController?.tabBar.isHidden == false {
            return self.tabBarController!.tabBar.frame.size.height
        }
        return 0
    }
    var zl_frameView:CGRect{
        var y:CGFloat = 0
        var height = ZLScreenHeight
        if self.navigationController == nil && self.tabBarController == nil {
            y = zl_heightStatusBar
            height -= zl_heightStatusBar
        }else if self.navigationController == nil && self.tabBarController != nil {
            y = zl_heightStatusBar
            height -= (zl_heightStatusBar + zl_heightTabBar)
        }else if self.navigationController != nil && self.tabBarController == nil{
            height -= (zl_heightStatusBar + zl_heightNavBar)
        }else if self.navigationController != nil && self.tabBarController != nil{
            height -= (zl_heightStatusBar + zl_heightNavBar + zl_heightTabBar)
        }else{
            y = zl_heightStatusBar
            height -= zl_heightStatusBar
        }
        return CGRect(x: 0, y: y, width: self.view.frame.size.width, height: height)
    }
    
    var zl_frameFull:CGRect{
      return UIScreen.main.bounds
    }
    
    var zl_mainStoryBoard:UIStoryboard{
       return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func zl_instantiateViewController(identifier:String,storyBoardName:String = "Main") -> UIViewController {
        return UIStoryboard(name: storyBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: identifier)
    }
    
    func zl_setBackBarTitleDefault(){
        zl_setBackBarTitle()
    }
    
    func zl_setBackBarTitle(title:String = "返回"){
        if self.navigationItem.backBarButtonItem != nil {
            self.navigationItem.backBarButtonItem?.title = title
        }else{
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
    }
}
extension UIViewController{
    
    func zl_configTitle(title:String){
        self.title = title
        if (self.title?.characters.count ?? 0) > 4 {
            self.zl_setBackBarTitleDefault()
        }
    }
    
    func setLeftBarButtonItem(title:String){
        let barBtn = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.plain, target: self, action: #selector(onLeftBarButtonClicked(sender:)))
        self.navigationItem.leftBarButtonItem = barBtn
    }
    
    func setLeftBarButtonItem(imageName:String){
        let barBtn = UIBarButtonItem(image: UIImage(named:imageName), landscapeImagePhone: nil, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.onLeftBarButtonClicked(sender:)))
        self.navigationItem.leftBarButtonItem = barBtn
    }
    
    @objc func onLeftBarButtonClicked(sender: UIBarButtonItem) {}
    
    func setRightBarButtonItem(title:String){
        let barBtn = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.plain, target: self, action: #selector(onRightBarButtonClicked(sender:)))
        self.navigationItem.rightBarButtonItem = barBtn
    }
    
    func setRightBarButtonItem(imageName:String){
        let barBtn = UIBarButtonItem(image: UIImage(named:imageName), landscapeImagePhone: nil, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.onRightBarButtonClicked(sender:)))
        self.navigationItem.rightBarButtonItem = barBtn
    }
    
    @objc func onRightBarButtonClicked(sender: UIBarButtonItem) {}
    
}
