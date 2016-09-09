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
    
}
