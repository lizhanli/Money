//
//  ZLColor.swift
//  unique
//
//  Created by 李占理 on 17/7/25.
//  Copyright © 2017年 李占理. All rights reserved.
//

import UIKit

class ZLColor{
    
    static let White            = UIColor.white
    static let Black            = UIColor.black
    
    static let Blue_Button      = UIColor(red: 0.0/255,     green: 127.0/255,   blue: 255.0/255,    alpha: 1)
    static let Blue_Black       = UIColor(red: 36.0/255,    green: 49.0/255,    blue: 71.0/255,     alpha: 1)
    static let Blue_White       = UIColor(red: 114.0/255,   green: 134.0/255,   blue: 178.0/255,    alpha: 1)
    
    static let Green_Light      = UIColor(red: 65.0/255,    green: 205.0/255,   blue: 120.0/255,    alpha: 1)
    static let Green_Dark       = UIColor(red: 34.0/255,    green: 163.0/255,   blue: 46.0/255,     alpha: 1)
    static let Green_Water      = UIColor(red: 21.0/255,    green: 178.0/255,   blue: 138.0/255,    alpha: 1)
    static let Red_Dark         = UIColor(red: 190.0/255,   green: 7.0/255,     blue: 18.0/255,     alpha: 1)
    static let Red_Light        = UIColor(red: 255.0/255,   green: 85.0/255,    blue: 85.0/255,     alpha: 1)
    
    static let Yellow_Light     = UIColor(red: 240.0/255,   green: 200.0/255,   blue: 16.0/255,     alpha: 1)
    static let Cyan             = UIColor(red: 1.0/255,     green: 181.0/255,   blue: 187.0/255,    alpha: 1)
    static let Purple           = UIColor(red: 83.0/255,    green: 27.0/255,    blue: 147.0/255,    alpha: 1)
    static let Brown            = UIColor(red: 128.0/255,   green: 64.0/255,    blue: 0.0/255,      alpha: 1)
    static let Orange            = UIColor(red: 255.0/255,   green: 135.0/255,    blue: 0.0/255,      alpha: 1)
    
    static let Text_3           = UIColor(white: 0.1,  alpha: 1)
    static let Text_5           = UIColor(white: 88.0/255,  alpha: 1)
    static let Text_M           = UIColor(white: 127.0/255, alpha: 1)
    static let Text_A           = UIColor(white: 170.0/255, alpha: 1)
    static let Text_Red = Red_Dark
    
    
    static let Gray             = UIColor(white: 210.0/255, alpha: 1)
    static let Gray_Light       = UIColor(white: 230.0/255, alpha: 1)
    static let Gray_Light_Light = UIColor(white: 245.0/255, alpha: 1)
    static let Gray_Middle      = UIColor(white: 0.5,       alpha: 1)
    
    static let Divider = UIColor(red: 0.783922, green: 0.780392, blue: 0.8, alpha: 1)
    
    static let Background = Gray_Light_Light
    static let Background2 = Gray_Light_Light
    static let Main = Red_Dark
    static let Button = Red_Dark
    static let Navigation = Red_Dark
    static let Chart = Orange
    
    static let P_Manger = Main
    static let P_Operatee = Brown
    static let P_Reviewer = Purple
    
    //返回随机颜色
    static var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}
