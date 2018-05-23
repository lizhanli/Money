//
//  ZLModalTransitionViewController.swift
//  Money
//
//  Created by 李占理 on 2018/5/23.
//  Copyright © 2018年 Marsli. All rights reserved.
//

import UIKit

class ZLModalTransitionViewController: UIViewController {
    
    var presentButton:UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.zl_configTitle(title: "自定义Modal控制器")
        self.view.backgroundColor = UIColor.green
        presentButton = UIButton()
        presentButton?.setTitleColor(UIColor.black, for: UIControlState.normal)
        presentButton?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        presentButton?.setTitle("Present", for: UIControlState.normal)
        presentButton?.addTarget(self, action: #selector(clickPresentButton), for: UIControlEvents.touchUpInside)
        self.view.addSubview(presentButton!)
        presentButton?.snp.makeConstraints({ (make) in
            make.center.equalTo(self.view.center)
        })
    }
    @objc func clickPresentButton(){
        let presentedVc = ZLPresentedViewController()
        self.present(presentedVc, animated: true, completion: nil)
    }

}
