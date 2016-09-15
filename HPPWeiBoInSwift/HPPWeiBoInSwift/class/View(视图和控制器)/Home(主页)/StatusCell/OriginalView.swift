//
//  OriginalView.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/15.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit

class OriginalView: UIView {
    
    var statusModel: StatusModel? {
        didSet{
            //给控件赋值
            iconImageView.setImage((statusModel?.user?.avatar_large)!, placeHolder: "avatar_default_big")
            userName.text = statusModel?.user?.screen_name
            
            creatTime.text = statusModel?.created_at
            
            source.text = statusModel?.source
            
            statusText.text = statusModel?.text
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
    
    init() {
        super.init(frame: CGRectZero)
        
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
        
        //3. 设一段文字(假数据)
        let randomCount = random() % 20 + 1
        var string = "我爱你妹"
        
        for _ in 0..<randomCount {
            string.appendContentsOf("你妹的个傻逼")
        }
        
        statusText.text = string
        
        //自动布局
        iconImageView.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(36, 36))
            make.left.equalTo(self).offset(12)
            make.top.equalTo(self).offset(12)
        }
        
        userName.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iconImageView)
            make.left.equalTo(iconImageView.snp_right).offset(12)
        }
        
        rankIcon.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(userName).offset(-3)
            make.left.equalTo(userName.snp_right).offset(5)
            make.size.equalTo(CGSizeMake(15, 15))
        }
        
        vipIcon.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(iconImageView).offset(3)
            make.left.equalTo(iconImageView.snp_right).offset(-10)
            make.size.equalTo(CGSizeMake(15, 15))
        }
        
        creatTime.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(iconImageView)
            make.left.equalTo(iconImageView.snp_right).offset(12)
        }
        
        source.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(iconImageView)
            make.left.equalTo(creatTime.snp_right).offset(12)
        }
        
        statusText.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iconImageView.snp_bottom).offset(12)
            make.left.equalTo(iconImageView)
            make.right.equalTo(self).offset(-12)
            make.bottom.equalTo(self).offset(-12)
        }
    }
}
































