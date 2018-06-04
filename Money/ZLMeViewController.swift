//
//  ZLMeViewController.swift
//  Money
//
//  Created by 李占理 on 2018/5/17.
//  Copyright © 2018年 Marsli. All rights reserved.
//

import UIKit

class ZLMeViewController: UIViewController {

    var greenView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        greenView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        greenView.backgroundColor = UIColor.green
        self.view.addSubview(greenView)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 2, delay: 0, options: UIViewAnimationOptions.transitionCurlUp, animations: {
            self.greenView.center = self.view.center
        }) { (finished) in
            self.greenView.backgroundColor = UIColor.red

        }
    }
   


}
