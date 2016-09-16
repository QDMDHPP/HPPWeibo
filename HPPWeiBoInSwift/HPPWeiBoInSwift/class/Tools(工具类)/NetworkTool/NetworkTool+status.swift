//
//  NetworkTool+status.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/13.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import Foundation

extension NetworkTool {
    ///  获取微博数据
    ///
    ///  - parameter since_id:    下拉刷新需要传的id
    ///  - parameter max_id:      上拉刷新需要传的id
    ///  - parameter acces_token: 令牌
    ///  - parameter finish:      完成回调
    func requestStatus(since_id:UInt64, max_id:UInt64, acces_token: String, finish:(AnyObject?)->()){
        let urlStr = "https://api.weibo.com/2/statuses/home_timeline.json"
        let parameters = ["access_token": acces_token, "since_id": String(since_id), "max_id": String(max_id)]
        
        NetworkTool.shareTool.request(urlStr, method: "GET", parameters: parameters) { (userResponseObjet) -> () in
            //完成回调
            finish(userResponseObjet)
        }
    
    }
}




























