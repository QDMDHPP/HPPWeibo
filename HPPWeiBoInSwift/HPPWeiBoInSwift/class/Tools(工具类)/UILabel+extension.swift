//
//  UILabel+extension.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/8.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit

extension UILabel {
    ///  label的便利构造器.title后面这个问号,代表title可以传nil
    convenience init(title: String?, textColor: UIColor = UIColor.darkGrayColor(), fontSize: CGFloat = 13, alignment: NSTextAlignment = .Left, numberOfLines: Int = 0){
        
        self.init()
        
        self.text = title
        self.textColor = textColor
        self.font = UIFont.systemFontOfSize(fontSize)
        self.textAlignment = alignment
        self.numberOfLines = numberOfLines
    }

}






















