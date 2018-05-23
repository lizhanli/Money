//
//  ZLPresentedViewController.swift
//  unique
//
//  Created by 李占理 on 17/8/31.
//  Copyright © 2017年 李占理. All rights reserved.
//

import UIKit

class ZLPresentedViewController: UIViewController {
    
    let modalTransitionDelegate = ZLModalTransitionDelegate()
    var cancleBtn:UIButton?
    var textField:UITextField?
    var titleLabel:UILabel?
    var contentLabel:UILabel?
    var passwordTextField:UITextField?
    var cancleButton:UIButton?
    var sureButton:UIButton?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    fileprivate func config(){
        self.transitioningDelegate = modalTransitionDelegate
        self.modalPresentationStyle = .custom
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ZLColor.Background
        self.view.layer.cornerRadius = 5
        
        titleLabel = UILabel()
        titleLabel?.alpha = 0.0
        titleLabel?.text = "修改银行卡全称"
        titleLabel?.font = UIFont.systemFont(ofSize: 18)
        titleLabel?.textColor = UIColor.black
        self.view.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view.snp.top).offset(10)
            make.centerX.equalTo(self.view.snp.centerX)
        })
        contentLabel = UILabel()
        contentLabel?.alpha = 0.0
        contentLabel?.textColor = UIColor.gray
        contentLabel?.font = UIFont.systemFont(ofSize: 14)
        contentLabel?.textAlignment = .left
        contentLabel?.numberOfLines = 0
        contentLabel?.text = "注：请确认您的银行卡全称已修改完整。全称必须含省市信息，且不能有重复字段。\n例：中国建设银行四川省绵阳市分行兴达广场支行"
        self.view.addSubview(contentLabel!)
        contentLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.view.snp.left).offset(16)
            make.right.equalTo(self.view.snp.right).offset(-16)
            make.top.equalTo(titleLabel!.snp.bottom).offset(5)
        })
        cancleBtn = UIButton()
        cancleBtn?.alpha = 0.0
        cancleBtn?.setTitle("X", for: UIControlState.normal)
        cancleBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        cancleBtn?.setTitleColor(ZLColor.Red_Dark, for: UIControlState.normal)
        cancleBtn?.addTarget(self, action: #selector(clickCancleButton), for: UIControlEvents.touchUpInside)
        self.view.addSubview(cancleBtn!)
        cancleBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view.snp.top).offset(10)
            make.right.equalTo(self.view.snp.right).offset(-10)
            make.width.height.equalTo(30)
        })
        textField = UITextField()
        textField?.placeholder = "请输入银行卡全称"
        textField?.borderStyle = UITextBorderStyle.roundedRect
        textField?.backgroundColor = UIColor.white
        textField?.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(textField!)
        textField?.snp.makeConstraints({ (make) in
            make.top.equalTo(contentLabel!.snp.bottom).offset(10)
            make.width.equalTo(0)
            make.height.equalTo(30)
            make.centerX.equalTo(self.view.snp.centerX)
        })
        passwordTextField = UITextField()
        passwordTextField?.placeholder = "请输入交易密码"
        passwordTextField?.borderStyle = UITextBorderStyle.roundedRect
        passwordTextField?.backgroundColor = UIColor.white
        passwordTextField?.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(passwordTextField!)
        passwordTextField?.snp.makeConstraints({ (make) in
            make.top.equalTo(textField!.snp.bottom).offset(10)
            make.width.equalTo(0)
            make.height.equalTo(30)
            make.centerX.equalTo(self.view.snp.centerX)
        })
        cancleButton = self.creatButton(title: "取消")
        cancleButton?.alpha = 0.0
        cancleButton?.layer.borderColor = ZLColor.Gray.cgColor
        sureButton?.setTitleColor(ZLColor.Gray, for: UIControlState.normal)
        cancleButton?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.view.snp.left).offset(16)
            make.height.equalTo(30)
            make.right.equalTo(self.view.snp.centerX).offset(-15)
            make.top.equalTo(passwordTextField!.snp.bottom).offset(10)
        })
        sureButton = self.creatButton(title: "确认")
        sureButton?.alpha = 0.0
        sureButton?.setTitleColor(ZLColor.Main, for: UIControlState.normal)
        sureButton?.layer.borderColor = ZLColor.Main.cgColor
        sureButton?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.view.snp.centerX).offset(15)
            make.height.equalTo(30)
            make.right.equalTo(self.view.snp.right).offset(-16)
            make.top.equalTo(cancleButton!.snp.top)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField?.snp.updateConstraints({ (make) in
            make.width.equalTo(view.frame.width - 32)
        })
        passwordTextField?.snp.updateConstraints({ (make) in
            make.width.equalTo(view.frame.width - 32)
        })
        UIView.animate(withDuration: 0.3) {
//            self.cancleBtn?.alpha = 1.0
            self.titleLabel?.alpha = 1.0
            self.contentLabel?.alpha = 1.0
            self.cancleButton?.alpha = 1.0
            self.sureButton?.alpha = 1.0
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func clickCancleButton(){
        var cancleTransform = CGAffineTransform(rotationAngle: CGFloat(M_PI * 3))
        cancleTransform = cancleTransform.scaledBy(x: 0.1, y: 0.1)
        textField?.snp.updateConstraints({ (make) in
            make.width.equalTo(0)
        })
        passwordTextField?.snp.updateConstraints({ (make) in
            make.width.equalTo(0)
        })
        UIView.animate(withDuration: 0.4, animations: {
            self.titleLabel?.alpha = 0.0
            self.contentLabel?.alpha = 0.0
            self.cancleButton?.alpha = 0.0
            self.sureButton?.alpha = 0.0
            self.cancleBtn?.transform = cancleTransform
            self.view.layoutIfNeeded()
        }, completion: { (finished) in
            self.dismiss(animated: true, completion: nil)
        })
    }
    func creatButton(title:String) ->UIButton{
        let btn = UIButton()
        btn.setTitle(title, for: UIControlState.normal)
        btn.layer.cornerRadius = 3
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitleColor(ZLColor.Gray, for: UIControlState.normal)
        btn.addTarget(self, action: #selector(clickButton), for: UIControlEvents.touchUpInside)
        btn.layer.borderWidth = 1.0
        self.view.addSubview(btn)
        return btn
    }
    @objc func clickButton(){
        textField?.snp.updateConstraints({ (make) in
            make.width.equalTo(0)
        })
        passwordTextField?.snp.updateConstraints({ (make) in
            make.width.equalTo(0)
        })
        UIView.animate(withDuration: 0.4, animations: {
            self.titleLabel?.alpha = 0.0
            self.contentLabel?.alpha = 0.0
            self.cancleButton?.alpha = 0.0
            self.sureButton?.alpha = 0.0
            self.view.layoutIfNeeded()
        }, completion: { (finished) in
            self.dismiss(animated: true, completion: nil)
        })
    }
}
