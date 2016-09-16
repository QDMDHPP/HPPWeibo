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
    
    func createCircleImage(size: CGSize, color: UIColor = UIColor.whiteColor()) -> UIImage {
        //. 开始上下文
        UIGraphicsBeginImageContext(size)
        
        //2. 设置颜色
        color.setFill()
        
        //3. 填充
        let rect = CGRect(origin: CGPointZero, size: size)
        UIRectFill(rect)
        
        //4. 圆形的容器
        let path = UIBezierPath(ovalInRect: rect)
        path.addClip()
        
        //5. 把图片往圆角的容器绘制
        self.drawInRect(rect)
        
        //6. 生成图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        //7. 关闭上下文件
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func asyCreateCircleImage(size: CGSize, color: UIColor = UIColor.whiteColor(), callBack:(image:UIImage) ->()) {
        
        dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
            
            //1. 开始上下文
            UIGraphicsBeginImageContext(size)
            
            //2. 设置颜色
            color.setFill()
            
            //3. 填充
            let rect = CGRect(origin: CGPointZero, size: size)
            UIRectFill(rect)
            
            //4. 圆形的容器
            let path = UIBezierPath(ovalInRect: rect)
            path.addClip()
            
            //5. 把图片往圆角的容器绘制
            self.drawInRect(rect)
            
            //6. 生成图片
            let image = UIGraphicsGetImageFromCurrentImageContext()
            
            //7. 关闭上下文
            UIGraphicsEndImageContext()
            
           dispatch_async(dispatch_get_main_queue(), { () -> Void in
                callBack(image: image)
           })
        }
    }
}





























