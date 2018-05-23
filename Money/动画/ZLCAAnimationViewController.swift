//
//  ZLCAAnimationViewController.swift
//  Money
//
//  Created by 李占理 on 2018/5/22.
//  Copyright © 2018年 Marsli. All rights reserved.
//

import UIKit

class ZLCAAnimationViewController: UIViewController,CAAnimationDelegate {
    
    let btnTitleArray = ["rotateX","suckEffect","cube","rotateZ","transformY","阻尼动画","Keyframe","Group"]
    var imageView:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 400, width: 100, height: 100))
        imageView.image = UIImage(named: "1.jpg")
        imageView.center.x = self.view.center.x
        self.view.addSubview(imageView)
        _creatButton()
    }
    private func _creatButton(){
        let btnW = ZLScreenWidth / 3
        for index in 0..<btnTitleArray.count {
            let btn = UIButton()
            btn.setTitle(btnTitleArray[index], for: UIControlState.normal)
            btn.tag = index
            btn.setTitleColor(UIColor.red, for: UIControlState.normal)
            btn.titleLabel?.adjustsFontSizeToFitWidth = true
            btn.addTarget(self, action: #selector(clickButton(btn:)), for: UIControlEvents.touchUpInside)
            self.view.addSubview(btn)
            let currentCols = index % 3
            let rows = index / 3
            btn.snp.makeConstraints { (make) in
                make.top.equalTo(self.view).offset(30 * rows)
                make.height.equalTo(30)
                make.left.equalTo(self.view.snp.left).offset(btnW * CGFloat(currentCols))
                make.right.equalTo(self.view.snp.left).offset(CGFloat(currentCols + 1) * btnW)
                
            }
        }
    }
    @objc func clickButton(btn:UIButton){
        switch btn.tag {
        case 0:
            CABasicAnimationtransform()
        case 1:
            suckEffect()
        case 2:
            cube()
        case 3:
            transformZ()
        case 4:
            transformY()
        case 5:
            springAnimation()
        case 6:
            KeyframeAnimation()
        case 7:
            Group()
        default:
            break
        }
    }
    func Group(){
        let animation1 = CAKeyframeAnimation(keyPath: "position")
        animation1.path = UIBezierPath(arcCenter: imageView.center, radius: 50, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true).cgPath
        animation1.fillMode = kCAFillModeForwards
        animation1.rotationMode = kCAAnimationRotateAutoReverse
        let animation2 = CABasicAnimation(keyPath: "transform")
        animation2.fromValue = NSNumber(value: 0)
        animation2.toValue = NSNumber(value: Double.pi * 2)
        animation2.valueFunction = CAValueFunction(name: kCAValueFunctionRotateY)
        let animations = CAAnimationGroup()
        animations.duration = 6
        animations.repeatCount = MAXFLOAT
        animations.isRemovedOnCompletion = false
        animations.animations = [animation1,animation2]
        imageView.layer.add(animations, forKey: "")
    }
    func KeyframeAnimation(){
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = UIBezierPath(arcCenter: imageView.center, radius: 50, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true).cgPath
        animation.duration = 6
        animation.fillMode = kCAFillModeForwards
        animation.repeatCount = MAXFLOAT
        animation.isRemovedOnCompletion = false
        animation.rotationMode = kCAAnimationRotateAutoReverse
        imageView.layer.add(animation, forKey: "path")
    }
    func springAnimation(){
        let animation = CASpringAnimation(keyPath: "position")
        animation.toValue = CGPoint(x: self.view.center.x, y: 410)
        animation.duration = 2
        animation.mass = 10
        animation.stiffness = 500
        animation.damping = 10
        animation.initialVelocity = 10
        animation.isCumulative = true
        animation.isRemovedOnCompletion = false
        imageView.layer.add(animation, forKey: "")
    }
    func transformY(){
        let animation = CABasicAnimation(keyPath: "transform")
        animation.duration = 2
        animation.repeatCount = 2
        animation.isCumulative = true
        animation.fromValue = NSNumber(value: 0)
        animation.toValue = NSNumber(value: Double.pi)
        animation.valueFunction = CAValueFunction(name: kCAValueFunctionRotateY)
        imageView.layer.add(animation, forKey: "transform")
    }
    func transformZ(){
        let animation = CABasicAnimation(keyPath: "transform")
        animation.duration = 2
        animation.repeatCount = 2
        animation.isCumulative = true
        animation.fromValue = NSNumber(value: 0)
        animation.toValue = NSNumber(value: Double.pi)
        animation.valueFunction = CAValueFunction(name: kCAValueFunctionRotateZ)
        imageView.layer.add(animation, forKey: "transform")
    }
    func suckEffect(){
        let anim = CATransition()
        anim.type = "suckEffect"
        anim.duration = 2
        anim.delegate = self
        anim.subtype = kCATransitionFromTop
        anim.isRemovedOnCompletion = true
        imageView.layer.add(anim, forKey: "")
        imageView.isHidden = true
    }
    func cube(){
        let anim = CATransition()
        anim.type = "cube"
        anim.duration = 2
        anim.delegate = self
        anim.subtype = kCATransitionFromTop
        imageView.layer.add(anim, forKey: "")
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        imageView.isHidden = false
    }
    func CABasicAnimationtransform(){
            let animation = CABasicAnimation(keyPath: "transform")
            animation.duration = 2
            animation.repeatCount = 2
            animation.isCumulative = true
            animation.fromValue = NSNumber(value: 0)
            animation.toValue = NSNumber(value: Double.pi)
            animation.valueFunction = CAValueFunction(name: kCAValueFunctionRotateX)
            imageView.layer.add(animation, forKey: "transform")
    }
}
