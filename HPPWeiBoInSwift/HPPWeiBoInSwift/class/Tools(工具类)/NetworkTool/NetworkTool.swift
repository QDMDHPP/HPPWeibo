//
//  NetworkTool.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/11.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit
import AFNetworking

class NetworkTool: AFHTTPSessionManager {

    //创建一个单例
    static let shareTool: NetworkTool = {
        
        let tool = NetworkTool(baseURL: nil)
        //添加AFN可接收的数据格式(text/plain)
        tool.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tool
        
    }()

    ///  网络中间层的接口定义
    ///
    ///  - parameter url:        url字符串
    ///  - parameter method:     请求方式字符串
    ///  - parameter parameters: 参数字典
    ///  - parameter callBack:   完成回调
    func request(url: String, method: String, parameters: [String: AnyObject]?,callBack: (AnyObject?)->())  {
        
        //请求成功需要执行的闭包
        let success = { (task: NSURLSessionDataTask, responseObject:AnyObject?)-> Void in
           callBack(responseObject)
        }
        
        //请求失败需要执行的闭包
        let failure = { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            print(error)
            callBack(nil)
        }
        
        //发起GET请求
        if method == "GET" {
            self.GET(url, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        
        //发起POST请求
        if method == "POST" {
            self.POST(url, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        
    }
}


























