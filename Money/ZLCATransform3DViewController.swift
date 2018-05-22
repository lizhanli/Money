//
//  ZLCATransform3DViewController.swift
//  Money
//
//  Created by 李占理 on 2018/5/21.
//  Copyright © 2018年 Marsli. All rights reserved.
//



/*
     CATransform3D定义了一个变化矩阵，通过对矩阵参数的设置，我们可以改变layer的一些属性，这个属性的改变，可以产生动画的效果。首先，CATransform3D定义了一个4*4的矩阵
 struct CATransform3D
 {
 
 CGFloat m11, m12, m13, m14;
 
 CGFloat m21, m22, m23, m24;
 
 CGFloat m31, m32, m33, m34;
 
 CGFloat m41, m42, m43, m44;
 };
 从m11到m44定义的含义如下：
 
 m11：x轴方向进行缩放
 
 m12：和m21一起决定z轴的旋转
 
 m13:和m31一起决定y轴的旋转
 
 m14:
 
 m21:和m12一起决定z轴的旋转
 
 m22:y轴方向进行缩放
 
 m23:和m32一起决定x轴的旋转
 
 m24:
 
 m31:和m13一起决定y轴的旋转
 
 m32:和m23一起决定x轴的旋转
 
 m33:z轴方向进行缩放
 
 m34:透视效果m34= -1/D，D越小，透视效果越明显，必须在有旋转效果的前提下，才会看到透视效果
 
 m41:x轴方向进行平移
 
 m42:y轴方向进行平移
 
 m43:z轴方向进行平移
 
 m44:初始为1
 
 
 5、CATransform3D与CGAffineTransform的转换
 CGAffineTransform是UIKit框架中一个用于变换的矩阵，其作用与CATransform类似，只是其可以直接作用于View，而不用作用于layer，这两个矩阵也可以进行转换，方法如下：
 //将一个CGAffinrTransform转化为CATransform3D
 CATransform3D CATransform3DMakeAffineTransform (CGAffineTransform m);
 //判断一个CATransform3D是否可以转换为CAAffineTransform
 
 bool CATransform3DIsAffine (CATransform3D t);
 //将CATransform3D转换为CGAffineTransform
 CGAffineTransform CATransform3DGetAffineTransform (CATransform3D t);
 */

import UIKit

class ZLCATransform3DViewController: UIViewController {

    var imageView:UIImageView!
    let btnTitleArray = ["平移变换","缩放变换","旋转变换","旋转翻转变换"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        imageView = UIImageView(frame: CGRect(x: 0, y: 400, width: 100, height: 100))
        imageView.image = UIImage(named: "1.jpg")
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
        translation()
    case 1:
        scale()
    case 2:
        rotation1()
    case 3:
        invert()
    default:
        break
    }
   }
    //MARK: -平移变换
    func translation(){
        let transform = CATransform3DMakeTranslation(50, 50, 0)
        imageView.layer.transform = transform
    }
    //MARK: -缩放
    func scale(){
        let transform = CATransform3DMakeScale(2, 1, 1)
        imageView.layer.transform = transform
    }
    //MARK: -旋转
    func rotation(){
        let transform = CATransform3DMakeRotation(CGFloat(Double.pi / 2), 0, 0, 1)
        imageView.layer.transform = transform
    }
    //MARK: -透视效果旋转
    func rotation1(){
        //另外，当我们有垂直于z轴的旋转分量时，设置m34的值可以增加透视效果，也可以理解为景深效果
        var transform = CATransform3DIdentity
        transform.m34 = -1/100.0
        transform = CATransform3DRotate(transform, CGFloat(Double.pi / 4), 0, 1, 0)
        imageView.layer.transform = transform
    }
    //MARK: -旋转翻转
    func invert(){
        var transform = CATransform3DMakeRotation(CGFloat(Double.pi / 4), 0, 0, 1)
        transform = CATransform3DInvert(transform)
        imageView.layer.transform = transform
    }
}
