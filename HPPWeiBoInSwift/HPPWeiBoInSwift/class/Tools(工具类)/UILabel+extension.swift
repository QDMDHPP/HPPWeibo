//
//  UILabel+extension.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/8.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit

extension UILabel {

    convenience init(title: String?, textColor: UIColor = UIColor.darkGrayColor(), fontSize: CGFloat = 13, alignment: NSTextAlignment = .Left, numberOfLines: Int = 0){
        
        self.init()
        
        self.text = title
        self.textColor = textColor
        self.font = UIFont.systemFontOfSize(fontSize)
        self.textAlignment = alignment
        self.numberOfLines = numberOfLines
    }

}






















