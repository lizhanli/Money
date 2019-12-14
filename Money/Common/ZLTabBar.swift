//
//  ZLTabBar.swift
//  unique
//
//  Created by 李占理 on 17/7/27.
//  Copyright © 2017年 李占理. All rights reserved.
//

import UIKit

protocol ZLTabBarProtocol {
    func clickMidTabBar()
}
class ZLTabBar: UITabBar {
    var btn:UIButton!
    var zlTabBarDelegate:ZLTabBarProtocol?
    
    lazy var shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.red.cgColor
        layer.lineWidth = 1
        layer.frame = self.bounds
        self.layer.addSublayer(layer)
        return layer
    }()
    
    lazy var shapeLayer2: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.red.cgColor
        layer.lineWidth = 1
        layer.fillColor = UIColor.clear.cgColor
        layer.frame = self.bounds
        self.layer.addSublayer(layer)
        return layer
    }()
    
    lazy var shapeLayer3: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.red.cgColor
        layer.lineWidth = 1
        layer.fillColor = UIColor.clear.cgColor
        layer.frame = self.bounds
        self.layer.addSublayer(layer)
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatButton()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addLineView(itemW: CGFloat) {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: ZLScreenWidth * 0.5 - itemW * 0.5, y: 0))
        path.addCurve(to: CGPoint(x: ZLScreenWidth * 0.5 + itemW * 0.5, y: 0), controlPoint1: CGPoint(x: ZLScreenWidth * 0.5 + itemW * 0.25, y: -10), controlPoint2: CGPoint(x: ZLScreenWidth * 0.5 - itemW * 0.25, y: -10))
        
        shapeLayer.path = path.cgPath
        
        
//        let path = UIBezierPath()
////        path.move(to: CGPoint(x: 0, y: 0))
////        path.addLine(to: CGPoint(x: ZLScreenWidth * 0.5 - itemW * 0.5, y: 0))
//        path.addArc(withCenter: CGPoint(x: ZLScreenWidth * 0.5 - itemW * 0.5, y: -150), radius: 150, startAngle: CGFloat(Double.pi * 0.404), endAngle: CGFloat(Double.pi * 0.5), clockwise: true)
//        shapeLayer.path = path.cgPath
//
//        let path2 = UIBezierPath()
//        path2.addArc(withCenter: CGPoint(x: ZLScreenWidth * 0.5 + itemW * 0.5, y: -150), radius: 150, startAngle: CGFloat(Double.pi * 0.5), endAngle: CGFloat(Double.pi * 0.604), clockwise: true)
//        shapeLayer2.path = path2.cgPath
//
//        let path3 = UIBezierPath()
//        path3.addArc(withCenter: CGPoint(x: ZLScreenWidth * 0.5, y: 50), radius: 59.5, startAngle: CGFloat(Double.pi * -0.604), endAngle: CGFloat(Double.pi * -0.404), clockwise: true)
//        shapeLayer3.path = path3.cgPath
        
    }
    
    private func creatButton() {
        let itemW = ZLScreenWidth / CGFloat((self.items?.count ?? 0) + 1)
//        let image = UIView.zl_createImage(size: CGSize(width: itemW, height: itemW), fillColor: ZLColor.Green_Dark, withCorner: itemW * 0.5)
        btn = UIButton()
        btn.addTarget(self, action: #selector(clickMidButton), for: UIControlEvents.touchUpInside)
//        btn.setBackgroundImage(image, for: UIControlState.normal)
//        btn.setBackgroundImage(image, for: UIControlState.highlighted)
        self.addSubview(btn)
    }
    
    //点击btn按钮
    @objc func clickMidButton(){
        self.zlTabBarDelegate?.clickMidTabBar()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        var itemX:CGFloat = 0.0
        let itemY:CGFloat = 0.0
        let itemW:CGFloat = ZLScreenWidth / CGFloat((self.items?.count)! + 1)
        let itemH = self.frame.size.height
        var currentItem:CGFloat = 0
        for itemTemp in self.subviews {
            if NSStringFromClass(itemTemp.classForCoder) == "UITabBarButton" {
                if currentItem == 1 {
                    currentItem = 2
                }
                itemX = currentItem * itemW
                currentItem = currentItem + 1
                itemTemp.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
            }
        }
        self.btn.bounds.size = CGSize(width: itemW, height: itemW)
        let maxHeight = max(itemW * 0.5, self.frame.size.height)
        let minHeight = min(itemW * 0.5, self.frame.size.height)
        var btnY = maxHeight - minHeight
        if itemW * 0.5 >= self.frame.size.height{
            btnY = minHeight - maxHeight
        }
        self.btn.center = CGPoint(x: self.center.x, y:btnY)
        addLineView(itemW: itemW)
    }
    
    //MARK: -处理超出tabBar的btn的点击事件
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.isHidden == false {
            let currentPoint = self.convert(point, to: self.btn)
            if self.btn.point(inside: currentPoint, with: event) {
                return self.btn
            }
        }
        return super.hitTest(point, with: event)
    }
    
}
