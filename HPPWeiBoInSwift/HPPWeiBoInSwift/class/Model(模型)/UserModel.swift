//
//  UserModel.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/15.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit
//在swift中, 如果使用Int,在32位机器上,就是Int32, 如果在64为机器上, 就是Int64
class UserModel: NSObject {
    ///  UserId
    var id: UInt64 = 0
    ///  用户昵称
    var screen_name: String?
    ///  用户头像
    var avatar_large: String?
    ///  vip用户的类型
    var verified_type: Int = -1
    ///  皇冠的等级
    var mbrank: Int = 0
    
    
    
    ///  description
    override var description: String {
        return dictionaryWithValuesForKeys(["id", "screen_name", "avatar_large", "verified_type", "mbrank"]).description
    }

}














