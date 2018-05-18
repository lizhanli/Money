//
//  ExtensionUILabel.swift
//  unique
//
//  Created by 李占理 on 17/7/29.
//  Copyright © 2017年 李占理. All rights reserved.
//

import UIKit

extension UILabel{
    
    static func zl_defaultLabel(text:String,color:UIColor,textAlignment:NSTextAlignment = NSTextAlignment.center,font:CGFloat = 14) ->UILabel{
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.textAlignment = textAlignment
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = UIFont.systemFont(ofSize: font)
        return label
    }
    
}
