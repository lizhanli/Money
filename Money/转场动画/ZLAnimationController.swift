//
//  ZLAnimationController.swift
//  unique
//
//  Created by 李占理 on 17/8/31.
//  Copyright © 2017年 李占理. All rights reserved.
//

import UIKit

class ZLAnimationController: NSObject,UIViewControllerAnimatedTransitioning{

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)else {
            return
        }
        let fromView = fromVc.view
        let toView = toVc.view
        let duration = self.transitionDuration(using: transitionContext)
        if toVc.isBeingPresented {
            containerView.addSubview(toView!)
            let toViewWidth:CGFloat = containerView.frame.size.width * 2 / 3
            let toViewHeight:CGFloat = containerView.frame.size.width * 2 / 3
            toView?.center = containerView.center
            toView?.bounds = CGRect(x: 0, y: 0, width: 1, height: toViewHeight)
            if #available(iOS 8, *){
              UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                  toView?.bounds = CGRect(x: 0, y: 0, width: toViewWidth, height: toViewHeight)
              }, completion: { (finished) in
                  transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
              })
            }else{
                let dimmingView = UIView()
                containerView.insertSubview(dimmingView, belowSubview: toView!)
                dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
                dimmingView.center = containerView.center
                dimmingView.bounds = CGRect(x: 0, y: 0, width: toViewWidth, height: toViewHeight)
                UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    dimmingView.bounds = containerView.bounds
                    toView?.bounds = CGRect(x: 0, y: ZLScreenHeight, width: toViewWidth, height: toViewHeight)
                }, completion: { (finished) in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
            }
        }
        //Dismissal 转场中不要将 toView 添加到 containerView
        if fromVc.isBeingDismissed {
            let fromViewHeight = fromView?.frame.size.height
            UIView.animate(withDuration: duration, animations: {
                fromView?.bounds = CGRect(x: 0, y: 0, width: 1, height: fromViewHeight!)
            }, completion: { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
    
}
