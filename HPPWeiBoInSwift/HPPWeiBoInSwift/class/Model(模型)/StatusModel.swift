//
//  StatusModel.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/13.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import Foundation

class StatusModel: NSObject {
    ///  创建时间
    var created_at: String?
    ///  微博的id
    var id: UInt64 = 0
    ///  微博的内容
    var text: String?
    ///  来源
    var source: String?
     /// 用户
    var user: UserModel?
    
    ///  description
    override var description: String {
        return dictionaryWithValuesForKeys(["created_at", "id", "text", "source", "user"]).debugDescription
    }
    
}



























