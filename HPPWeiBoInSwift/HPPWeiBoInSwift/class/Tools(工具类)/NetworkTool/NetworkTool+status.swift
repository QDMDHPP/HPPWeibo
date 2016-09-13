//
//  NetworkTool+status.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/13.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import Foundation

extension NetworkTool {
    
    func requestStatus(since_id:UInt64, max_id:UInt64, acces_token: String, finish:(AnyObject?)->()){
        let urlStr = "https://api.weibo.com/2/statuses/home_timeline.json"
        let parameters = ["access_token": acces_token, "since_id": String(since_id), "max_id": String(max_id)]
        
        NetworkTool.shareTool.request(urlStr, method: "GET", parameters: parameters) { (userResponseObjet) -> () in
            //完成回调
            finish(userResponseObjet)
        }
    
    }
}




























