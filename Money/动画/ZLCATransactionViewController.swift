//
//  ZLCATransactionViewController.swift
//  Money
//
//  Created by 李占理 on 2018/5/23.
//  Copyright © 2018年 Marsli. All rights reserved.
//

import UIKit

class ZLCATransactionViewController: UIViewController {

    let btnTitleArray = ["隐式事务","显式事务","事务嵌套"]
    var layel:CALayer?
    var layel2:CALayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        _creatButton()
        _creatLayer()
    }
    private func _creatLayer(){
        layel = CALayer()
        layel?.frame = CGRect(x: 100, y: 300, width: 100, height: 100)
        layel?.backgroundColor = UIColor.red.cgColor
        self.view.layer.addSublayer(layel!)
        
        layel2 = CALayer()
        layel2?.frame = CGRect(x: 100, y: 500, width: 100, height: 100)
        layel2?.backgroundColor = UIColor.green.cgColor
        self.view.layer.addSublayer(layel2!)
    }
    private func _creatButton(){
        let btnW = ZLScreenWidth / 3
        for index in 0..<btnTitleArray.count {
            let btn = UIButton()
            btn.setTitle(btnTitleArray[index], for: UIControlState.normal)
            btn.tag = index
            btn.setTitleColor(UIColor.red, for: UIControlState.normal)
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
            hideAnimate()
        case 1:
            showAnimate()
        case 2:
            animate()
        default:
            break
        }
    }
    //MARK: -事务嵌套
    func animate(){
        CATransaction.begin()
        CATransaction.begin()
        CATransaction.setAnimationDuration(2)
        CATransaction.setDisableActions(false)
        layel?.backgroundColor = UIColor.green.cgColor
        CATransaction.commit()
        //6s 之后上面的动画才会执行
        Thread.sleep(forTimeInterval: 6)
        CATransaction.setAnimationDuration(2)
        CATransaction.setDisableActions(false)
        layel2?.backgroundColor = UIColor.red.cgColor
        CATransaction.commit()
    }
    //MARK: -隐式动画
    func hideAnimate(){
        CATransaction.setDisableActions(false)
        layel?.position = CGPoint(x: 200, y: 500)
        layel?.backgroundColor = UIColor.green.cgColor
    }
    //MARK: -显式动画
    func showAnimate(){
        CATransaction.begin()
        CATransaction.setAnimationDuration(2)
        CATransaction.setDisableActions(false)
        layel?.position = CGPoint(x: 200, y: 500)
        layel?.backgroundColor = UIColor.green.cgColor
        CATransaction.setCompletionBlock {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                self.test()
            })
        }
        CATransaction.commit()
    }
    func test(){
        CATransaction.begin()
        CATransaction.setAnimationDuration(2)
        CATransaction.setDisableActions(false)
        layel?.position = CGPoint(x: 100, y: 400)
        layel?.backgroundColor = UIColor.red.cgColor
        CATransaction.commit()
    }
}
