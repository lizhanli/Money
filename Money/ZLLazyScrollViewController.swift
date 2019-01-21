//
//  ZLLazyScrollViewController.swift
//  Money
//
//  Created by 李占理 on 2018/8/1.
//  Copyright © 2018年 Marsli. All rights reserved.
//

import UIKit
import LazyScroll


class ZLLazyScrollViewController: UIViewController{
    
    var scrollView: TMMuiLazyScrollView!
    var rectArray = [CGRect]()
    var test = ZLTempTestView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.zl_configTitle(title: "苹果核")
        self.view.addSubview(test)
        test.backgroundColor = UIColor.yellow
        test.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(30)
            make.left.right.equalTo(self.view)
        }
        
        
//        scrollView = TMMuiLazyScrollView(frame: self.view.bounds)
//        scrollView.dataSource = self
//        self.view.addSubview(scrollView)
//        let margin = 10
//        for index in 0...4 {
//            let x:CGFloat = 0
//            let y:CGFloat = CGFloat(index * 50) + CGFloat(index * margin)
//            let w:CGFloat = ZLScreenWidth
//            let h:CGFloat = 50
//            let rect = CGRect(x: x, y: y, width: w, height: h)
//            rectArray.append(rect)
//        }
//        scrollView.contentSize = CGSize(width: ZLScreenWidth, height: ZLScreenHeight)
//        scrollView.reloadData()
    }
    //MARK: -TMMuiLazyScrollViewDataSource
    func numberOfItem(in scrollView: TMMuiLazyScrollView) -> UInt {
        return UInt(rectArray.count)
    }
    func scrollView(_ scrollView: TMMuiLazyScrollView, rectModelAt index: UInt) -> TMMuiRectModel {
        let rect = rectArray[Int(index)]
        let model = TMMuiRectModel()
        model.absoluteRect = rect
        model.muiID = String(Int(index))
        return model
    }
    func scrollView(_ scrollView: TMMuiLazyScrollView, itemByMuiID muiID: String) -> UIView? {
        var modelView = scrollView.dequeueReusableItem(withIdentifier: "testView")
        let index = muiID.toInt() ?? 0
        if modelView == nil {
            modelView = ZlTestView1()
            modelView?.reuseIdentifier = "testView"
        }
        modelView?.frame = rectArray[index]
        scrollView.addSubview(modelView!)
        return modelView
    }
}
class ZLTMMuiRectModel: TMMuiRectModel {
    
}
class ZlTestView1: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ZLTempTestView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let label = UILabel()
        label.text = "我是测试1号"
        label.backgroundColor = UIColor.red
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(20)
            make.left.right.equalTo(self)
        }
        let button = UIButton()
        button.backgroundColor = UIColor.green
        self.addSubview(button)
        button.setTitle("我是测试w2号", for: UIControlState.normal)
        button.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.left.right.equalTo(self)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
        
        DispatchQueue.main.async {
            logInfo("frame==\(self.frame)")
            let frame = self.bounds
            let path = UIBezierPath(roundedRect: frame, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight], cornerRadii: CGSize(width: 20, height: 20))
            let maskLayer = CAShapeLayer()
            maskLayer.fillColor = UIColor.gray.cgColor
            maskLayer.path = path.cgPath
            self.layer.insertSublayer(maskLayer, at: 0)
//
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

