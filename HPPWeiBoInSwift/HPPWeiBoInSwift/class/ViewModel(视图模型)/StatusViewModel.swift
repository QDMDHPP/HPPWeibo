//
//  StatusViewModel.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/16.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit

//类是按址传递
//结构按值传递
struct CellLayout {
    var margin:CGFloat = 12
    var iconSize: CGSize = CGSizeMake(36, 36)
    var numOfPerRow: Int = 3
    var vipIconSize: CGSize = CGSizeMake(15, 15)
    var imageHeight: CGFloat
    var pictureViewWith: CGFloat
    var imageSize: CGSize
    
    init () {
        pictureViewWith = screenWidth - margin*(CGFloat(numOfPerRow)-1)
        imageHeight = (pictureViewWith - margin*(CGFloat(numOfPerRow)-1))/CGFloat(numOfPerRow)
        imageSize = CGSizeMake(imageHeight, imageHeight)
    }
}

let cellLayout = CellLayout()

class StatusViewModel: NSObject {
    var statusModel: StatusModel
    
    //👑等级
    var mbRankIconImage: UIImage?
    
    //vip图标
    var vipIconImage: UIImage?
    
    //来源字符串
    var sourceString: String?
    
    //时间字符串
    var showTimeString: String?
    
    /// 转发微博的文字
    var retweetedText: String?
    
    /// 配图视图大小
    var originalPictureViewSize: CGSize = CGSizeZero
    
    /// 转发为微博的配图视图的大小
    var retweetedPictureViewSize: CGSize = CGSizeZero
    
    /// 配图视图的大小
    var pictureViewSize: CGSize = CGSizeZero
    
    /// 配图的图片模型数组
    var pictureModels:[PictureModel] = []
    
    init(statusModel: StatusModel) {
        self.statusModel = statusModel
        super.init()
        
        //处理user数据
        self.dealWithUser()
        //处理微博的时间和来源
        self.dealWithStatus()
        //计算原创微博的配图视图的大小
        self.caculateOrigianlPictureViewSize()
        //计算转发微博的图片的高度
        self.caculataRetweetedPictureViewSize()
        //处理转发微博的文字
        self.dealWithRetweetedText()
        //设置pictureModels
        self.setpictureModels()
        //计算配图视图的大小
        self.caculatePictureViewSize()
        
    }
    //MARK: - 设置转发微博配图
    func setpictureModels () {
        //如果有原创微博有图片
        if let picturls = statusModel.pic_urls where picturls.count > 0 {
            pictureModels = picturls
        }
        
        //如果转发微博有图片
        if let picturls = statusModel.retweeted_status?.pic_urls where picturls.count > 0 {
            pictureModels = picturls
        }
    }
    //MARK: - 计算配图视图的大小
    func caculatePictureViewSize() {
        if pictureModels.count > 0 {
            let rowNum = (pictureModels.count - 1)/(cellLayout.numOfPerRow) + 1
            let pictureViewHeight = CGFloat(rowNum) * cellLayout.imageHeight +  cellLayout.margin * (CGFloat(rowNum) - 1)
            pictureViewSize = CGSizeMake(cellLayout.pictureViewWith,pictureViewHeight)
        }
    }
    //MARK: - 计算转发微博的配图视图的大小
    func caculataRetweetedPictureViewSize () {
        guard let picurls = statusModel.retweeted_status?.pic_urls where picurls.count > 0 else {
            return
        }
        
        let rowNum = (picurls.count - 1)/(cellLayout.numOfPerRow) + 1
        let pictureViewHeight = CGFloat(rowNum) * cellLayout.imageHeight + cellLayout.margin * (CGFloat(rowNum)-1)
        retweetedPictureViewSize = CGSizeMake(cellLayout.pictureViewWith, pictureViewHeight)
    }
    
    //MARK: - 设置转发微博文字
    func dealWithRetweetedText () {
        let userName = statusModel.retweeted_status?.user?.screen_name
        let text = statusModel.retweeted_status?.text
        
        if let userName = userName, let text = text {
            retweetedText = "@\(userName) : \(text)"
        }
    }
    
    //MARK: - 配图处理
    func caculateOrigianlPictureViewSize() {
        guard let picurls = statusModel.pic_urls where picurls.count > 0 else{
            return
        }
        
        let rowNum = (picurls.count - 1)/(cellLayout.numOfPerRow) + 1
        let pictureViewHeight = CGFloat(rowNum) * cellLayout.imageHeight + cellLayout.margin * (CGFloat(rowNum)-1)
        originalPictureViewSize = CGSizeMake(cellLayout.pictureViewWith, pictureViewHeight)
    }
    
    
    //MARK: - 时间和来源处理
    func dealWithStatus () {
        //处理来源
        if let sourceStr = statusModel.source {
            guard let startIndex = sourceStr.rangeOfString("\">")?.endIndex,endIndex = sourceStr.rangeOfString("</a>")?.startIndex else{
                return
            }
            
            sourceString = sourceStr.substringWithRange(startIndex..<endIndex)
            
        }
        
        //处理时间
        if let creatAt = statusModel.created_at {
            showTimeString = NSDate.sinaTimeStrToDate(creatAt).dateToWillShowTimeString()
        }
    }
    //MARK: - 👑处理
    func dealWithUser () {
        //👑的等级: 从1到6
        if let mbrank = statusModel.user?.mbrank where mbrank > 0 && mbrank < 7{
            mbRankIconImage = UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        
        //vip图标
        //0 是达人
        //2,3,5 是企业达人
        //220 草根达人
        if let vipLevel = statusModel.user?.verified_type {
            switch vipLevel {
            case 0:
                vipIconImage = UIImage(named: "avatar_vip")
            case 2, 3, 5:
                vipIconImage = UIImage(named: "avatar_enterprise_vip")
            case 220:
                vipIconImage = UIImage(named: "avatar_grassroot")
            default:
                vipIconImage = nil
            }
        }
    }
    
}
























