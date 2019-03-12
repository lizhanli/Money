//
//  ZLCustomShapeViewController.swift
//  Money
//
//  Created by 李占理 on 2019/2/19.
//  Copyright © 2019 Marsli. All rights reserved.
//

import UIKit

class ZLCustomShapeViewController: UIViewController {

    var customView: ZLCustomShapeView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        customView = ZLCustomShapeView()
        self.view.addSubview(customView!)
        customView?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(50)
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY)
        })
    }
}

enum CustomShapeView {
    case normal
    case selected
}

class ZLCustomShapeView: UIView {
    
    var state = CustomShapeView.selected
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        self.backgroundColor = UIColor.yellow
        DispatchQueue.main.async {
            let shapeLayer = CAShapeLayer()
            shapeLayer.frame = self.bounds
            shapeLayer.strokeColor = UIColor.red.cgColor
            shapeLayer.fillColor = UIColor.red.cgColor
            shapeLayer.lineWidth = 1
            let path = UIBezierPath()
            path.move(to: CGPoint(x: self.zl_width * 0.5, y: self.zl_height * 0.25))
            path.addLine(to: CGPoint(x: self.bounds.minX, y: self.zl_height * 0.75))
            path.addLine(to: CGPoint(x: self.bounds.maxX, y: self.zl_height * 0.75))
            path.close()
            shapeLayer.path = path.cgPath
            self.layer.addSublayer(shapeLayer)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickTapGesture))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clickTapGesture() {
        if state == CustomShapeView.normal {
            UIView.animate(withDuration: 0.5) {
                self.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            }
            state = CustomShapeView.selected
        } else {
            UIView.animate(withDuration: 0.5) {
                self.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2))
            }
            state = CustomShapeView.normal
        }
        
    }
    
}
