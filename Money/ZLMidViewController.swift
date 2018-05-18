//
//  ZLMidViewController.swift
//  unique
//
//  Created by 李占理 on 17/8/14.
//  Copyright © 2017年 李占理. All rights reserved.
//

import UIKit

class ZLMidViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ZLColor.Background
        self.zl_configTitle(title: "这是测试")
        setLeftBarButtonItem(title: "返回")
        
    }
    override var prefersStatusBarHidden: Bool{
     return false
    }
    override var shouldAutorotate: Bool{
      return true
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return UIInterfaceOrientation.landscapeLeft
    }
    
    func handleDeviceOrientationChange(notification:Notification){
        let deviceOrientation = UIDevice.current.orientation
        switch deviceOrientation {
        case UIDeviceOrientation.faceUp:
            logInfo("屏幕朝上平躺")
        case UIDeviceOrientation.faceDown:
            logInfo("屏幕朝下平躺")
        case UIDeviceOrientation.landscapeLeft:
            logInfo("屏幕向左横置")
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
            UIApplication.shared.statusBarOrientation = .landscapeLeft
        case UIDeviceOrientation.landscapeRight:
            logInfo("屏幕向右横置")
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
            UIApplication.shared.statusBarOrientation = .landscapeRight
        case UIDeviceOrientation.portrait:
            logInfo("屏幕直立")
        case UIDeviceOrientation.portraitUpsideDown:
            logInfo("屏幕直立，上下颠倒")
        case UIDeviceOrientation.unknown:
            logInfo("未知方向")
        }
    }

    override func onLeftBarButtonClicked(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

}
