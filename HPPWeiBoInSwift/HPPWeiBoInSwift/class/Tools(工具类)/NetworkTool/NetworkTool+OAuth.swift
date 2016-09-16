//
//  NetworkTool+OAuth.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/11.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import Foundation


let redictURI = "https://www.baidu.com"
let appKey = "2800304766"
let appSecret = "84c31fab0796c3dee1e325ad562f6c5b"
let userName = "15820827439"
let passWord = "hpp8862489"

//1. extension里面不能再创建指定构造函数
//2. extension里面不能再创建存储属性

extension NetworkTool {
    ///  计算属性, 此处不能加存储属性
    var loginURL:String {
        return "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redictURI)"
    }

    ///  获取access_token
    ///
    ///  - parameter code:   用户登录返回的code
    ///  - parameter finish: 请求完成回调
    func requestAccessToken(code: String, finish:(AnyObject?)->()){
        
        let access_token_urlStr = "https://api.weibo.com/oauth2/access_token"
        
         let parameters = ["client_id":appKey, "client_secret":appSecret, "grant_type":"authorization_code","code":code,"redirect_uri":redictURI]
        
        NetworkTool.shareTool.request(access_token_urlStr, method: "POST", parameters: parameters, callBack: { (accessTokenResponse) -> () in
            //完成回调
            finish(accessTokenResponse)
            //使用YYModel做字典转模型
        })
    }
    
    ///  获取用户信息
    ///
    ///  - parameter uid:         user id
    ///  - parameter acces_token: access_token
    ///  - parameter finish:      完成回调
    func requestUserAccount(uid: String, acces_token:String, finish:(AnyObject?)->()) {
        let urlStr = "https://api.weibo.com/2/users/show.json"
        let parameters = ["access_token":acces_token, "uid":uid]

        NetworkTool.shareTool.request(urlStr, method: "GET", parameters: parameters) { (userResponseObjet) -> () in
            //完成回调
            finish(userResponseObjet)
        }
    }
    
}























