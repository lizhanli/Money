//
//  ZLTabBarController.swift
//  fighting
//
//  Created by 李占理 on 16/11/26.
//  Copyright © 2016年 lianxi. All rights reserved.
//

import UIKit

class ZLTabBarController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let tabBar = ZLTabBar(frame: self.tabBar.frame)
        tabBar.zlTabBarDelegate = self
        self.setValue(tabBar, forKey: "tabBar")
        let homeVc = ZLHomeViewController()
        homeVc.title = "首页"
//        let testVc = ZLMidViewController()
        
        let meVc = ZLMeViewController()
        meVc.title = "我的"
        
        let homeNav = ZLNavViewController(rootViewController: homeVc)
        self.addChildViewController(homeNav)
        
//        let testNav = ZLNavViewController(rootViewController: testVc)
//        self.addChildViewController(testNav)
        
        let meNav = ZLNavViewController(rootViewController: meVc)
        self.addChildViewController(meNav)
        
        self.tabBar.barTintColor = UIColor.cyan
        let tabBarItem = UITabBarItem.appearance()
        tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15),NSAttributedStringKey.foregroundColor:UIColor.darkGray], for: UIControlState.normal)
        tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15),NSAttributedStringKey.foregroundColor:UIColor.red], for: UIControlState.selected)
        self.tabBarController?.tabBarItem = tabBarItem
        UIApplication.shared.setStatusBarOrientation(UIInterfaceOrientation.portrait, animated: true)
    }
    override var prefersStatusBarHidden: Bool{
        return false
    }
    override var shouldAutorotate: Bool {
        guard let selectedVc = self.selectedViewController  else {
            return true
        }
        return selectedVc.shouldAutorotate
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        guard let selectedVc = self.selectedViewController else{
            return .portrait
        }
        return selectedVc.supportedInterfaceOrientations
    }
//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
//        guard let selectedVc = self.selectedViewController else{
//            return .landscapeLeft
//        }
//        return selectedVc.preferredInterfaceOrientationForPresentation
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}

extension ZLTabBarController:ZLTabBarProtocol{
    func clickMidTabBar() {
        self.present(ZLNavViewController(rootViewController: ZLMidViewController()), animated: true, completion: nil)
    }
}

