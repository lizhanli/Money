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
        self.view.backgroundColor = UIColor.blue
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}
