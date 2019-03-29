//
//  ExtensionUINavigationBar.swift
//  Money
//
//  Created by 李占理 on 2019/3/22.
//  Copyright © 2019 Marsli. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    @objc dynamic var navigationGradualChangeBackgroundView: UIView? {
        
        get{
            return objc_getAssociatedObject(self, &self.navigationGradualChangeBackgroundView) as? UIView
        }
        set{
            objc_setAssociatedObject(self, &self.navigationGradualChangeBackgroundView, navigationGradualChangeBackgroundView, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    func setNavigationBackgroundColor(backgroundColor: UIColor) {
        if self.navigationGradualChangeBackgroundView == nil {
            self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationGradualChangeBackgroundView = UIView(frame: CGRect(x: 0, y: -20, width: ZLScreenWidth, height: self.bounds.size.height + 20))
            self.navigationGradualChangeBackgroundView?.isUserInteractionEnabled = false
            self.insertSubview(self.navigationGradualChangeBackgroundView!, at: 0)
        }
        self.navigationGradualChangeBackgroundView?.backgroundColor = backgroundColor
    }
    
    func removeBackgroundColor() {
        self.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationGradualChangeBackgroundView?.removeFromSuperview()
        self.navigationGradualChangeBackgroundView = nil
    }
    
}

