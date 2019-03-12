//
//  ZLStretchImageController.swift
//  Money
//
//  Created by 李占理 on 2019/2/11.
//  Copyright © 2019 Marsli. All rights reserved.
//

import UIKit

class ZLStretchImageController: UIViewController {

    var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        
        button = UIButton(frame: CGRect(x: 0, y: 100, width: 150, height: 50))
        button.center.x = self.view.center.x
        self.view.addSubview(button)
        var image = UIImage(named: "button")
//        1.这个方法在iOS 5.0出来后就过期了
//        2.这个方法只能拉伸1x1的区域
//        image = image?.stretchableImage(withLeftCapWidth: Int((image?.size.width ?? 0) * 0.5), topCapHeight: Int((image?.size.height ?? 0) * 0.5))
        
//        image = image?.resizableImage(withCapInsets: UIEdgeInsets(top: 25, left: 10, bottom: 25, right: 10))
        
//        UIImageResizingModeStretch：拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
//        UIImageResizingModeTile：平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图片
        image = image?.resizableImage(withCapInsets: UIEdgeInsets(top: 25, left: 10, bottom: 25, right: 10), resizingMode: UIImageResizingMode.stretch)
        
        button.setBackgroundImage(image, for: UIControlState.normal)
        
        
    }
    
}
