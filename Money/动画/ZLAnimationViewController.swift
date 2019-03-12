//
//  ZLAnimationViewController.swift
//  Money
//
//  Created by 李占理 on 2019/3/5.
//  Copyright © 2019 Marsli. All rights reserved.
//

import UIKit

class ZLAnimationViewController: UIViewController {

    var redView: UIView!
    var greenView: UIView!
    var redViewSuperView: UIView!
    
    var label: UILabel!
    
    let normalColor = (85, 85, 85)
    let selectedColor = (255, 128, 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    
        label = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 30))
        logInfo("frame==\(label.frame)")
        label.text = "今天是周二，我们要继续努力了"
        
        self.view.addSubview(label)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
//        let flyRight = CABasicAnimation(keyPath: "position.x")
//        flyRight.fromValue = -view.bounds.size.width/2
//        flyRight.toValue = view.bounds.size.width/2
//        flyRight.duration = 0.5
//        flyRight.beginTime = CACurrentMediaTime() + 2.3
//        flyRight.fillMode = kCAFillModeForwards
//        redViewSuperView.layer.add(flyRight, forKey: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        redViewSuperView.center.x += ZLScreenWidth
    }
    
    //MARK: -关键帧动画
    fileprivate func testKeyFrame() {
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25, animations: {
                self.redViewSuperView.center.y += 50
            })
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.5, animations: {
                self.redViewSuperView.center.y += 60
            })
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 1.25, animations: {
                self.redViewSuperView.center.y += 100
            })
            
        }) { (_) in
            
        }
    }
    
    //MARK: -过渡动画效果
    fileprivate func testTranstion() {
        if !self.redViewSuperView.subviews.contains(greenView) == true {
            //
            //过渡动画是设置在容器视图上，因此动画作用在添加到容器视图的所有子视图。
            UIView.transition(from: redView, to: greenView, duration: 2, options: [UIViewAnimationOptions.transitionFlipFromTop]) { (_) in
                self.redView.removeFromSuperview()
                self.redViewSuperView.addSubview(self.greenView)
            }
        } else {
            UIView.transition(from: greenView, to: redView, duration: 2, options: [UIViewAnimationOptions.transitionFlipFromTop]) { (_) in
                self.greenView.removeFromSuperview()
                self.redViewSuperView.addSubview(self.redView)
                
            }
        }
        
    }
    
}
