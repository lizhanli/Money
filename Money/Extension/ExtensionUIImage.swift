//
//  ExtensionUIImage.swift
//  unique
//
//  Created by 李占理 on 17/7/29.
//  Copyright © 2017年 李占理. All rights reserved.
//

import UIKit

extension UIImage{
    var width:CGFloat{
        return self.size.width
    }
    var height:CGFloat{
        return self.size.height
    }
    
    /// 压缩图片
    ///
    /// - Parameter targetWidth: 指定压缩后的宽度
    /// - Returns: 返回压缩后的图片
    func imageCompress(targetWidth:CGFloat) -> UIImage? {
        let targetHeight = (targetWidth / width) * height
        UIGraphicsBeginImageContext(CGSize(width: targetWidth, height: targetHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: targetWidth, height: targetHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// 返回一张模糊图片
    ///
    /// - Parameter value: 模糊度
    /// - Returns: 返回处理后的图片
    func blurImage(value:NSNumber) -> UIImage? {
        let context = CIContext(options: [kCIContextUseSoftwareRenderer:true])//使用cpu处理图片
        let ciImage = CIImage(image: self)
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        blurFilter?.setValue(ciImage, forKey: kCIInputImageKey)
        blurFilter?.setValue(value, forKey: "inputRadius")
        if blurFilter?.outputImage != nil {
            let newImage = context.createCGImage((blurFilter?.outputImage)!, from: (ciImage?.extent)!)
            return UIImage(cgImage: newImage!)
        }
        return nil
    }
    
}
