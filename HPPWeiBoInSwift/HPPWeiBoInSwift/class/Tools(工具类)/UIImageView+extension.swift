//
//  UIImageView+extension.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/8.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit

extension UIImageView {

    convenience init(imageName : String) {
        self.init()
        self.image = UIImage(named: imageName)
    }
    
    ///  隔离SDWebImage
    ///
    ///  - parameter url:         url字符串
    ///  - parameter placeHolder: placeHolder字符串
    func setImage(url: String, placeHolder: String?) {
        //调用SDWebImage的API
        let imageUrl = NSURL(string: url)
        
        if let placeHolder = placeHolder {
            self.sd_setImageWithURL(imageUrl, placeholderImage: UIImage(named: placeHolder))
        }else {
            self.sd_setImageWithURL(imageUrl)
        }
    }
    
}












