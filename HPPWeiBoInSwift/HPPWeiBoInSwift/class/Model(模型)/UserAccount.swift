//
//  UserAccount.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/12.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit

let userAccountKey = "HPPClassUserAccountKey"

class UserAccount: NSObject {

    ///  单例
    static let sharedUserAccount: UserAccount = UserAccount()
    ///  userId
    var uid: String?
    ///  用户昵称
    var screen_name: String?
    ///  用户头像
    var avatar_large: String?
    ///  access_token
    var access_token: String?
    ///  过期秒数
    var expires_in: NSTimeInterval = 0 {
        didSet {
            /// 计算出 expired_date
            expired_date = NSDate(timeInterval: expires_in, sinceDate: NSDate())
        }
    }
    ///  过期的日期
    var expired_date: NSDate?
    ///  是否过期
    var isExpired: Bool {
        //判断当expired_date 和当前时间比较,谁大谁小
        return expired_date?.compare(NSDate()) == .OrderedAscending
    }
    ///  是否登录
    var isLogin: Bool {
     
        //判读access_token是否为nil, isExpired是否过期
        return access_token != nil && isExpired != true
    }
    
    ///  description
    ///  重写属性也需要使用override
    override var description: String {
        return dictionaryWithValuesForKeys(["uid","screen_name","avatar_large","access_token","expired_date"]).description
    }
    
    //构造函数
    override init() {
        super.init()
        
        //从本地读取的数据来初始化对象
        readUserAccount()
    }
    
    ///  kvc的异常处理
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    ///  存储用户信息
    func saveUserAccount(dict:[String: AnyObject]) {
        //1.用 dict 给单例的属性赋一下值
        setValuesForKeysWithDictionary(dict)
        //2. 将 模型 转成字典, 过滤掉了哪些没用的字段
        //dictionaryWithValuesForKeys: 模型转字典, keys 传的是模型的属性名字
        let userAccountDict = dictionaryWithValuesForKeys(["uid", "screen_name", "avatar_large", "access_token", "expired_date"])
        //3. 把字典存起来
        NSUserDefaults.standardUserDefaults().setObject(userAccountDict, forKey: userAccountKey)
        
    }
    
    ///  读取用户信息
    func readUserAccount() {
        //1. 从userAccount读取user的Dict
        if let userDict = NSUserDefaults.standardUserDefaults().objectForKey(userAccountKey) as? [String: AnyObject]{
            
            //2. 使用 userDict 给单例的属性赋值
            setValuesForKeysWithDictionary(userDict)
        }
    }
}































