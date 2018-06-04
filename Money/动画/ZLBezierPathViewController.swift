//
//  ZLBezierPathViewController.swift
//  Money
//
//  Created by 李占理 on 2018/5/23.
//  Copyright © 2018年 Marsli. All rights reserved.
//

import UIKit

class ZLBezierPathViewController: UIViewController {

    var layer:CALayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        layer = CALayer()
        layer?.frame = CGRect(x: (ZLScreenWidth - 100) * 0.5, y: 400, width: 100, height: 100)
        layer?.backgroundColor = UIColor.green.cgColor
        self.view.layer.addSublayer(layer!)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let path1 = UIBezierPath(ovalIn: layer!.frame)
        let rect = layer!.frame.insetBy(dx: -1000, dy: -1000)
        let path2 = UIBezierPath(ovalIn: rect)
        let maskLayer = CAShapeLayer()
        maskLayer.fillColor = UIColor.green.cgColor
        maskLayer.path = path2.cgPath
        self.view.layer.mask = maskLayer
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 10
        animation.fromValue = path1.cgPath
        animation.toValue = path2.cgPath
        maskLayer.add(animation, forKey: "path")
        
    }

}
