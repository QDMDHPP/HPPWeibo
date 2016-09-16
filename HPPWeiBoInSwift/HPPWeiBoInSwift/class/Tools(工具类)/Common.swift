//
//  Common.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/8.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit

let screenBounds = UIScreen.mainScreen().bounds
let screenWidth = UIScreen.mainScreen().bounds.size.width
let screenHeight = UIScreen.mainScreen().bounds.size.height

 /// tabbar的高度
let tabBarHeight : CGFloat = 49

let globalColor = UIColor.orangeColor()

///  延时操作
func delay (delay: Float, _ task :()->()) {
    let dispatch_delay = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * UInt64(delay)))
    
    //延时操作
    dispatch_after(dispatch_delay, dispatch_get_main_queue()) { () -> Void in
        task()
    }
}












