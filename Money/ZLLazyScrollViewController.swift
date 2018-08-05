//
//  ZLLazyScrollViewController.swift
//  Money
//
//  Created by 李占理 on 2018/8/1.
//  Copyright © 2018年 Marsli. All rights reserved.
//

import UIKit
import LazyScroll


class ZLLazyScrollViewController: UIViewController,TMMuiLazyScrollViewDataSource{
    
    var scrollView: TMMuiLazyScrollView!
    var rectArray = [CGRect]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.zl_configTitle(title: "苹果核")
        scrollView = TMMuiLazyScrollView(frame: self.view.bounds)
        scrollView.dataSource = self
        self.view.addSubview(scrollView)
        let margin = 10
        for index in 0...4 {
            let x:CGFloat = 0
            let y:CGFloat = CGFloat(index * 50) + CGFloat(index * margin)
            let w:CGFloat = ZLScreenWidth
            let h:CGFloat = 50
            let rect = CGRect(x: x, y: y, width: w, height: h)
            rectArray.append(rect)
        }
        scrollView.contentSize = CGSize(width: ZLScreenWidth, height: ZLScreenHeight)
        scrollView.reloadData()
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
