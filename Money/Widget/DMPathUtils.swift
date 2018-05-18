//
//  DMPathUtils.swift
//  UITest
//
//  Created by MiloDu on 15/12/27.
//  Copyright © 2015年 Milo. All rights reserved.
//

import UIKit

enum DMDirection: Int {
    case none = 0
    case up
    case left
    case down
    case right
}

class DMPathUtils: NSObject {
    
    //绘制'>'，方向可定制
    static func createPathIndicator(_ rect: CGRect, dir: DMDirection = .right) -> UIBezierPath {
        let path = UIBezierPath()
        if dir == .right {
            path.move(to: rect.origin)
            path.dm_addLineTo(rect.maxX, rect.midY)
            path.dm_addLineTo(rect.minX, rect.maxY)
        }else if dir == .left {
            path.dm_moveTo(rect.maxX, rect.minY)
            path.dm_addLineTo(rect.minX, rect.midY)
            path.dm_addLineTo(rect.maxX, rect.maxY)
        }else if dir == .up {
            path.dm_moveTo(rect.minX, rect.maxY)
            path.dm_addLineTo(rect.midX, rect.minY)
            path.dm_addLineTo(rect.maxX, rect.maxY)
        }else if dir == .down {
            path.move(to: rect.origin)
            path.dm_addLineTo(rect.midX, rect.maxY)
            path.dm_addLineTo(rect.maxX, rect.minY)
        }
        return path
    }
    
//    static func createPathLeft(rect: CGRect) -> UIBezierPath {
//        let path = UIBezierPath()
//        path.dm_moveTo(rect.maxX, rect.minY)
//        path.dm_addLineTo(rect.minX, rect.midY)
//        path.dm_addLineTo(rect.maxX, rect.maxY)
//        return path
//    }

    //绘制'√'
    static func createPathOK(_ rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        path.dm_moveTo(rect.minX, rect.midY)
        path.dm_addLineTo(rect.minX + rect.width * 0.4, rect.maxY - rect.height * 0.1)
        path.dm_addLineTo(rect.maxX, rect.minY + rect.height * 0.1)
        return path
    }
    //绘制'×'
    static func createPathX(_ rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: rect.origin)
        path.dm_addLineTo(rect.maxX, rect.maxY)
        path.dm_moveTo(rect.maxX, rect.minY)
        path.dm_addLineTo(rect.minX, rect.maxY)
        return path
    }
    //绘制'→'，方向可定制
    static func createPathArrow(_ rect: CGRect, dir: DMDirection = .up) -> UIBezierPath {
        var end = CGPoint(x: rect.midX, y: rect.minY)
        var start = CGPoint(x: rect.midX, y: rect.maxY)
        var left = CGPoint(x: rect.minX, y: rect.midY)
        var right = CGPoint(x: rect.maxX, y: rect.midY)
        if dir == .down {
            end = CGPoint(x: rect.midX, y: rect.maxY)
            start = CGPoint(x: rect.midX, y: rect.minY)
            left = CGPoint(x: rect.maxX, y: rect.midY)
            right = CGPoint(x: rect.minX, y: rect.midY)
        }else if dir == .left {
            end = CGPoint(x: rect.minX, y: rect.midY)
            start = CGPoint(x: rect.maxX, y: rect.midY)
            left = CGPoint(x: rect.midX, y: rect.maxY)
            right = CGPoint(x: rect.midX, y: rect.minY)
        }else if dir == .right {
            end = CGPoint(x: rect.maxX, y: rect.midY)
            start = CGPoint(x: rect.minX, y: rect.midY)
            left = CGPoint(x: rect.midX, y: rect.minY)
            right = CGPoint(x: rect.midX, y: rect.maxY)
        }
        let path = UIBezierPath()
        path.move(to: left)
        path.addLine(to: end)
        path.addLine(to: right)
        path.move(to: end)
        path.addLine(to: start)
        return path
    }
    
    //绘制'$'
    static func createPathDollar(_ border : CGRect) -> UIBezierPath{
        let middle = CGPoint(x: border.origin.x + border.size.width * 0.5, y: border.origin.y + border.size.height * 0.5)
        let center = CGPoint(x: middle.x, y: middle.y - border.size.height * 0.16)
        let center2 = CGPoint(x: middle.x, y: middle.y + border.size.height * 0.16)
        let radius = border.size.height * 0.16
        
        let path = UIBezierPath()
        path.addArc(withCenter: center, radius: radius, startAngle: -0.1 * PI , endAngle: -1.5 * PI, clockwise: false)
        path.addArc(withCenter: center2, radius: radius, startAngle: -0.5 * PI, endAngle: 0.9 * PI, clockwise: true)
        path.move(to: CGPoint(x: middle.x, y: middle.y - border.size.height * 0.4))
        path.addLine(to: CGPoint(x: middle.x, y: middle.y + border.size.height * 0.4))
        return path
    }
}
