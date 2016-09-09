//
//  UIButton+extension.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/8.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit

extension UIButton {
    //便利构造器
    convenience init(
        title: String?,
        titleColor: UIColor = UIColor.darkGrayColor(),
        fontSize: CGFloat = 13,
        image: String? = nil,
        backgroundImage: String? = nil,
        target:AnyObject? = nil,
        action: String? = nil,
        event:UIControlEvents = .TouchUpInside) {
            
        self.init()
            
        //设置文字
        self.setTitle(title, forState: .Normal)
        self.setTitleColor(titleColor, forState: .Normal)
        self.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
            
        //设置图片
        if let image = image{
            self.setImage(UIImage(named: image), forState: .Normal)
            self.setImage(UIImage(named: "\(image)_highlighted"), forState: .Highlighted)
        }
        //设置背景图片
        if let backgroundImage = backgroundImage{
            self.setBackgroundImage(UIImage(named: backgroundImage), forState: .Normal)
            self.setBackgroundImage(UIImage(named: "\(backgroundImage)_highlighted"), forState: .Highlighted)
        }
            
            
        //添加点击事件
        if let target = target ,action = action{
            let selector = Selector(action)
            self.addTarget(target, action:selector, forControlEvents: event)
        }
        self.sizeToFit()
    }

    
}



































