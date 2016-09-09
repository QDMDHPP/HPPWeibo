//
//  UIImage+extension.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/8.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit

extension UIImage {
    ///  创建一张纯色的图片
    ///
    ///  - parameter size:  创建的大小
    ///  - parameter color: 颜色
    ///
    ///  - returns: 返回创建的图片
    class func creatImage (size: CGSize, color: UIColor) -> UIImage {
        //corrGraphic
        
        //1. 开启图片上下文
        UIGraphicsBeginImageContext(size)
        
        //2.设置颜色
        color.setFill()
        
        //3. 填充
        UIRectFill(CGRect(origin: CGPointZero, size: size))
        
        //4. 生成图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        //5. 关闭图片上下文
        UIGraphicsEndImageContext()
        
        return image
    }
}





























