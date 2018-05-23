//
//  ZLPresentationController.swift
//  unique
//
//  Created by 李占理 on 17/8/31.
//  Copyright © 2017年 李占理. All rights reserved.
//

import UIKit

class ZLPresentationController: UIPresentationController {
    let dimmingView = UIView()
    
    override func presentationTransitionWillBegin() {
        containerView?.addSubview(dimmingView)
        let dimmingViewInitailWidth = containerView!.frame.size.width * 2 / 3
        let dimmingViewInitailHeight = containerView!.frame.size.width * 2 / 3
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        dimmingView.bounds = CGRect(x: 0, y: 0, width: dimmingViewInitailWidth, height: dimmingViewInitailHeight)
        dimmingView.center = containerView!.center
        _ = presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (_) in
            self.dimmingView.bounds = self.containerView!.bounds
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        _ = presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (_) in
            self.dimmingView.alpha = 0.0
        }, completion: nil)
    }
    
    override func containerViewWillLayoutSubviews() {
        dimmingView.center = containerView!.center
        dimmingView.bounds = containerView!.bounds
        let width = containerView!.frame.width * 2 / 3, height = containerView!.frame.size.width * 2 / 3
        presentedView?.center = containerView!.center
        presentedView?.bounds = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
}
