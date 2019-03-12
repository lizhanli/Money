//
//  ZLUITouchViewController.swift
//  Money
//
//  Created by 李占理 on 2019/2/28.
//  Copyright © 2019 Marsli. All rights reserved.
//

import UIKit

class ZLUITouchViewController: UIViewController {

    var iconView: NewFundIconView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.zl_configTitle(title: "事件")
        self.view.backgroundColor = UIColor.white
        self.view.isMultipleTouchEnabled = true

        
        iconView = NewFundIconView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        self.view.addSubview(iconView)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        //获取touches数量
//        let numTouches = touches.count
//
//        //获取点击屏幕的次数
//        let tapTouches = ((touches as NSSet).anyObject() as AnyObject).tapCount
//
//        //获取事件发生时间
//        let timestamp = event!.timestamp
//
//
//        //允许使用手势
//        self.view.isUserInteractionEnabled = true
//        print("\(tapTouches)")
//
//        //判断如果有两个触摸点
//        if touches.count == 2
//        {
//            //获取触摸集合
//            let twoTouches = (touches as NSSet).allObjects
//
//            //获取触摸数组
//            let first:UITouch = twoTouches[0] as! UITouch //第1个触摸点
//            let second:UITouch = twoTouches[1]as! UITouch //第2个触摸点
//
//            //获取第1个点相对于self.view的坐标
//            let firstPoint:CGPoint = first.location(in: self.view)
//
//            //获取第1个点相对于self.view的坐标
//            let secondPoint:CGPoint = second.location(in: self.view)
//
//            //计算两点之间的距离
//            let deltaX = secondPoint.x - firstPoint.x;
//            let deltaY = secondPoint.y - firstPoint.y;
//            let initialDistance = sqrt(deltaX*deltaX + deltaY*deltaY )
//
//            print("两点间距离是：\(initialDistance)")
//        }

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        //获取当前相对于self.view的坐标
//        let locationPoint = ((touches as NSSet).anyObject() as AnyObject).location(in: self.view)
//        logInfo("locationPoint==\(locationPoint)")
//        //获取上一次相对于self.view的坐标
//        let previousPoint = ((touches as NSSet).anyObject() as AnyObject).previousLocation(in: self.view)
//        logInfo("previousPoint==\(previousPoint)")
//
//        let offSetX = locationPoint.x - previousPoint.x
//        let offfSetY = locationPoint.y - previousPoint.y
//        self.view.transform = CGAffineTransform(translationX: offSetX, y: offfSetY)
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}

class NewFundIconView: UIView {
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = ZLColor.White
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "NEW"
        self.addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.green
        
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(2)
            make.right.equalTo(self.snp.right).offset(-2)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        let bezier = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [UIRectCorner.bottomLeft, UIRectCorner.topLeft, UIRectCorner.topRight], cornerRadii: CGSize(width: 8, height: 10))
        shapeLayer.path = bezier.cgPath
        self.layer.mask = shapeLayer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

