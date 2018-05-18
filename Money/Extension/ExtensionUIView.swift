//
//  ExtensionUIView.swift
//  unique
//
//  Created by 李占理 on 17/7/25.
//  Copyright © 2017年 李占理. All rights reserved.
//

import UIKit

extension UIView{
    
    ///根据颜色绘制图片
    ///
    /// - Parameter color: 背景色
    /// - Returns: 返回一张图片
    static func zl_creatImage(color:UIColor) ->UIImage?{
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /*
     *Round + Fill
     */
    static func zl_createImage(size: CGSize, fillColor color: UIColor, withCorner cornerRadius: CGFloat)-> UIImage? {
        return zl_createImage(size: size, strokeColor: UIColor.clear, fillColor: color, lineWidth: 0, cornerRadius: cornerRadius)
    }
    
    static func zl_createImage(size: CGSize, strokeColor: UIColor, fillColor: UIColor, lineWidth: CGFloat, cornerRadius: CGFloat,lineDash: [CGFloat]? = nil) -> UIImage? {
        var cornerRadius = cornerRadius
        if cornerRadius < 0 {
            cornerRadius = min(size.width, size.height) * 0.5
        }
        let rect = CGRect(x: lineWidth * 0.5, y: lineWidth * 0.5, width: size.width - lineWidth, height: size.height - lineWidth)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        strokeColor.setStroke()
        fillColor.setFill()
        path.lineWidth = lineWidth
        if lineDash != nil {
            path.setLineDash(lineDash!, count: 2, phase: 0)
        }
        //        path.addClip()
        path.stroke()
        path.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    static func zl_createImage(size: CGSize, strokeColor: UIColor, fillColor: UIColor, path: UIBezierPath)-> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        strokeColor.setStroke()
        fillColor.setFill()
        path.stroke()
        path.fill()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
extension UIView{
    var zl_x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set(value) {
            var frame = self.frame
            frame.origin.x = value
            self.frame = frame
        }
    }
    
    var zl_y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(value) {
            var frame = self.frame
            frame.origin.y = value
            self.frame = frame
        }
    }
    
    var zl_origin: CGPoint {
        get {
            return self.frame.origin
        }
        set(value) {
            var frame = self.frame
            frame.origin = value
            self.frame = frame
        }
    }
    
    var zl_width: CGFloat {
        get {
            return self.frame.size.width
        }
        set(value) {
            var frame = self.frame
            frame.size.width = value
            self.frame = frame
        }
    }
    
    var zl_height: CGFloat {
        get {
            return self.frame.size.height
        }
        set(value) {
            var frame = self.frame
            frame.size.height = value
            self.frame = frame
        }
    }
    
    var zl_currentCenter: CGPoint {
        if let layer = self.layer.presentation() {
            return layer.position
        }
        return self.center
    }
    
    var zl_currentCenterX: CGFloat {
        return zl_currentCenter.x
    }
    
    var zl_currentCenterY: CGFloat {
        return zl_currentCenter.y
    }
}
