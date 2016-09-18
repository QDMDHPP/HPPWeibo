
//  StatusListViewModel.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/17.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit
import SDWebImage

class StatusListViewModel: NSObject {
    ///  数据源
    lazy var statusViewModelArray: [StatusViewModel] = []
    
    func loadStatus (isPullDown: Bool, callBack: (success: Bool) -> ()) {
        ///  下拉刷新传since_id
        var since_id: UInt64 = 0
        ///  上拉刷新传max_id
        var max_id: UInt64 = 0
        
        if isPullDown {
            since_id = statusViewModelArray.first?.statusModel.id ?? 0
        } else {
            max_id = statusViewModelArray.last?.statusModel.id ?? 0
        }
        
        if let accessToken = UserAccount.sharedUserAccount.access_token {
            ///  请求首页微博数据
            NetworkTool.shareTool.requestStatus(since_id, max_id: max_id, acces_token: accessToken, finish: { (responseObject) -> () in
                
                let responseDict = (responseObject as? [String: AnyObject])
                let statusObject = responseDict?["statuses"]
                
                if let statusDictArray = statusObject as? [[String: AnyObject]]  {
                    ///  创建一个空数组, 用来装从服务器获取返回的model
                    var responseStatusViewModelArray: [StatusViewModel] = []
                    
                    for statusDict in statusDictArray {
                        if let statusModel = StatusModel.yy_modelWithJSON(statusDict) {
                            let statusViewModel = StatusViewModel(statusModel: statusModel)
                            responseStatusViewModelArray.append(statusViewModel)
                        }
                    }
                    
                    if isPullDown {
                        self.statusViewModelArray = responseStatusViewModelArray + self.statusViewModelArray
                    } else {
                        ///  判断一下是否是第一次
                        if max_id > 0 {
                            responseStatusViewModelArray.removeFirst()
                        }
                        
                        self.statusViewModelArray += responseStatusViewModelArray
                    }
                    
                    self.dealWithSingPictureView(responseStatusViewModelArray,callBack:callBack)
                    
                } else {
                    callBack(success: false)
                }
            })
        }
    }

    func dealWithSingPictureView(responseViewModelArray : [StatusViewModel],callBack:(success:Bool)->()) {
        //创建一个调度组
        let group = dispatch_group_create()
        ///  遍历 responseViewModelArray, 找到单张图片,并且下载
        for statusViewModel in responseViewModelArray {
            if statusViewModel.pictureModels.count == 1 {
                //下载单张图片
                let pictureModel = statusViewModel.pictureModels[0]
                let urlString = pictureModel.thumbnail_pic!
                let url = NSURL(string: urlString)
                
                dispatch_group_enter(group)//加入调度组
                
                SDWebImageManager.sharedManager().downloadImageWithURL(url, options: [], progress: nil, completed: { (downloadImage, _, _, _, _) -> Void in
                    
                    var size = downloadImage.size
                    size.width = size.width * screenScale
                    size.height = size.height * screenScale
                    
                    let minWidth: CGFloat = 50
                    let minHeight: CGFloat = 50
                    
                    //处理图片过窄的情况
                    if size.width < minWidth {
                        //原高/原宽 = 新高/新宽
                        //新高 = 原高/(原宽*新宽)
                        size.height = size.height/size.width*minWidth
                        size.width = minWidth
                    }
                    
                    //处理图片过宽的情况
                    if size.height < minHeight {
                        //原高/原宽 = 新高/新宽
                        //新宽 = 新高/(原高*原宽)
                        size.width = minHeight/size.height*size.width
                        size.height = minHeight
                    }
                    
                    statusViewModel.pictureViewSize = size
                    
                    dispatch_group_leave(group)//出调度组
                    
                })
            }
        }
        
        //所有单张图片都下载完成.注意一定要回到主线程去刷新UI
        dispatch_group_notify(group, dispatch_get_global_queue(0, 0)) {
            for statusViewModel in responseViewModelArray{
                statusViewModel.caculateCellHeigh()
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                callBack(success: true)
            })
        }
        
    }
}

















