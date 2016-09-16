//
//  PictureModel.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/16.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit

class PictureModel: NSObject {
    var thumbnail_pic: String?
    
    override var description: String {
        return dictionaryWithValuesForKeys(["thumbnail_pic"]).description
    }
    
}
