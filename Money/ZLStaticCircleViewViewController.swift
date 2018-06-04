
//
//  ZLStaticCircleViewViewController.swift
//  Money
//
//  Created by 李占理 on 2018/6/3.
//  Copyright © 2018年 Marsli. All rights reserved.
//

import UIKit

class ZLStaticCircleViewViewController: UIViewController {

    var progressView:UIAnnularProgress!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        progressView = UIAnnularProgress(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        self.view.addSubview(progressView)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       progressView.setProgress(progress: 1, time: 1.2, animate: true)
    }
}
class UIAnnularProgress: UIView {
    
    var progressProperty = ProgressProperty.init()
    private let progressLayer = CAShapeLayer()
    
    init(propressProperty:ProgressProperty,frame:CGRect) {
        self.progressProperty = propressProperty
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: bounds).cgPath
        let trackLayer = CAShapeLayer()
        trackLayer.frame = bounds
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = progressProperty.trackColor.cgColor
        trackLayer.lineWidth = progressProperty.width
        trackLayer.path = path
        layer.addSublayer(trackLayer)
        
        progressLayer.frame = bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressProperty.progressColor.cgColor
        progressLayer.lineWidth = progressProperty.width
        progressLayer.path = path
        progressLayer.strokeStart = progressProperty.progressStart
        progressLayer.strokeEnd = progressProperty.progressEnd
        layer.addSublayer(progressLayer)
        
    }
    
    func setProgress(progress:CGFloat,time:CFTimeInterval,animate:Bool) {
        CATransaction.begin()
        CATransaction.setDisableActions(!animate)
        CATransaction.setAnimationDuration(time)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        progressLayer.strokeEnd = progress
        CATransaction.setCompletionBlock {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.2, execute: {
                self.animateStrokeStart()
            })
        }
        CATransaction.commit()
        
    }
    func animateStrokeStart(){
        CATransaction.begin()
        CATransaction.setDisableActions(false)
        CATransaction.setAnimationDuration(1.2)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        progressLayer.strokeStart = 1
        progressLayer.strokeEnd = 1
        CATransaction.setCompletionBlock {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.2, execute: {
                self.animateStrokeEnd()
            })
        }
        CATransaction.commit()
    }
    func animateStrokeEnd(){
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 0
        CATransaction.commit()
        
        CATransaction.begin()
        CATransaction.setDisableActions(false)
        CATransaction.setAnimationDuration(1.2)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 1
        CATransaction.setCompletionBlock {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.2, execute: {
                self.animateStrokeStart()
            })
        }
        CATransaction.commit()
    }
}
struct ProgressProperty{
    var width:CGFloat
    var trackColor:UIColor
    var progressColor :UIColor
    var progressStart:CGFloat
    var progressEnd:CGFloat
    
    init(width:CGFloat,progressEnd:CGFloat,progressColor:UIColor) {
        self.width = width
        self.progressEnd = progressEnd
        self.progressColor = progressColor
        trackColor = UIColor.gray
        progressStart = 0.0
    }
    
    init() {
        width = 10
        trackColor = UIColor.gray
        progressColor = UIColor.green
        progressStart = 0.0
        progressEnd = 0.25
    }
}
