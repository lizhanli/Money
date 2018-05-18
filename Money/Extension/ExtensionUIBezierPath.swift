//
//  ExtensionUIBezierPath.swift
//  unique
//
//  Created by 李占理 on 17/7/25.
//  Copyright © 2017年 李占理. All rights reserved.
//

import UIKit

extension UIBezierPath {
    public func dm_moveTo(_ x : CGFloat, _ y: CGFloat){
        move(to: CGPoint(x: x, y: y))
    }
    public func dm_addLineTo(_ x : CGFloat, _ y: CGFloat){
        addLine(to: CGPoint(x: x, y: y))
    }
}
