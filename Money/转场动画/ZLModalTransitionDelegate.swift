//
//  ZLModalTransitionDelegate.swift
//  unique
//
//  Created by 李占理 on 17/8/31.
//  Copyright © 2017年 李占理. All rights reserved.
//

import UIKit

class ZLModalTransitionDelegate: NSObject,UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ZLAnimationController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ZLAnimationController()
    }
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ZLPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
