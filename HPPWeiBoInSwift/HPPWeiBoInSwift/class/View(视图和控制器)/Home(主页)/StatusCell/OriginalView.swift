//
//  OriginalView.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/15.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit

class OriginalView: UIView {
    
    var statusViewModel: StatusViewModel? {
        didSet {
            
            //把statusViewModel传递给PictureView
            pictureView.statusViewModel = statusViewModel
            
            //给控件赋值
            let url = NSURL(string: (statusViewModel?.statusModel.user?.avatar_large)!)
            
            iconImageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "avatar_default_big")) { (downloadImage, _, _, _) -> Void in
                
                downloadImage.asyCreateCircleImage(CGSizeMake(36, 36), callBack: { (circleImage) -> () in
                    self.iconImageView.image = circleImage
                })
            }
            
            userName.text = statusViewModel?.statusModel.user?.screen_name
            
            vipIcon.image = statusViewModel?.vipIconImage
            
            rankIcon.image = statusViewModel?.mbRankIconImage
            
            creatTime.text = statusViewModel?.showTimeString
            
            source.text = statusViewModel?.sourceString
            
            statusText.text =  statusViewModel?.statusModel.text
            
            //更新pictureView的布局
            //有图片
            if let picurls = statusViewModel?.statusModel.pic_urls where picurls.count > 0 {
                pictureView.snp_updateConstraints { (make) -> Void in
                    make.top.equalTo(statusText.snp_bottom).offset(12)
                    make.size.equalTo(statusViewModel!.originalPictureViewSize)
                }
            } else {
                pictureView.snp_updateConstraints { (make) -> Void in
                    make.top.equalTo(statusText.snp_bottom)
                    make.height.equalTo(0)
                }
            }
        }
    }
    ///  头像
    let iconImageView: UIImageView = UIImageView(imageName: "avatar_default_big")
    ///  用户名
    let userName: UILabel = UILabel(title: "小明爱睡觉", fontSize: 15)
    ///  皇冠
    let rankIcon: UIImageView = UIImageView(imageName: "common_icon_membership_level1")
    ///  vip图片
    let vipIcon: UIImageView = UIImageView(imageName: "avatar_grassroot")
    ///  发布时间
    let creatTime: UILabel = UILabel(title: "五分钟前", textColor:UIColor.grayColor(), fontSize: 10)
    ///  来源
    let source: UILabel = UILabel(title: "来自天堂", textColor: UIColor.grayColor(), fontSize: 10)
    /// 微博正文
    let statusText: UILabel = UILabel(title: nil, fontSize:15)
    /// 配图视图
    let pictureView: StatusPictureView = StatusPictureView()
    
    init() {
        super.init(frame: CGRectZero)
        self.backgroundColor = UIColor.whiteColor()
        //设置UI
        setupUI()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OriginalView {
    func setupUI() {
        //添加子视图
        addSubview(iconImageView)
        addSubview(userName)
        addSubview(rankIcon)
        addSubview(vipIcon)
        addSubview(creatTime)
        addSubview(source)
        addSubview(statusText)
        addSubview(pictureView)
        
        //3. 设一段文字(假数据)
        let randomCount = random() % 20 + 1
        var string = "我爱你妹"
        
        for _ in 0..<randomCount {
            string.appendContentsOf("你妹的个傻逼")
        }
        
        statusText.text = string
        
        //自动布局
        iconImageView.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(cellLayout.iconSize)
            make.left.equalTo(self).offset(cellLayout.margin)
            make.top.equalTo(self).offset(cellLayout.margin)
        }
        
        userName.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iconImageView)
            make.left.equalTo(iconImageView.snp_right).offset(cellLayout.margin)
        }
        
        rankIcon.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(userName).offset(-3)
            make.left.equalTo(userName.snp_right).offset(5)
            make.size.equalTo(cellLayout.vipIconSize)
        }
        
        vipIcon.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(iconImageView).offset(3)
            make.left.equalTo(iconImageView.snp_right).offset(-10)
            make.size.equalTo(cellLayout.vipIconSize)
        }
        
        creatTime.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(iconImageView)
            make.left.equalTo(iconImageView.snp_right).offset(cellLayout.margin)
        }
        
        source.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(iconImageView)
            make.left.equalTo(creatTime.snp_right).offset(cellLayout.margin)
        }
        
        statusText.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iconImageView.snp_bottom).offset(cellLayout.margin)
            make.left.equalTo(iconImageView)
            make.right.equalTo(self).offset(-cellLayout.margin)
            
        }
        
        pictureView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(statusText)
            make.top.equalTo(statusText.snp_bottom).offset(cellLayout.margin)
            make.size.equalTo(CGSizeZero)
            make.bottom.equalTo(self).offset(-cellLayout.margin)
        }
    }
}
































