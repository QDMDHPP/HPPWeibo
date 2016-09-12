//
//  WelcomeView.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/13.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit
import SDWebImage

/**
 1. 给控件添加完约束
 
*/
class WelcomeView: UIView {
    ///  用户头像
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        //设置圆角
        imageView.layer.cornerRadius = 45
        imageView.layer.masksToBounds = true
        imageView.setImage(UserAccount.sharedUserAccount.avatar_large!,placeHolder: "avatar_default_big")
        
        return imageView
    }()
    
    ///  欢迎文字
    private lazy var welcomeLabel: UILabel = UILabel(title: "\(UserAccount.sharedUserAccount.screen_name), 欢迎回来", fontSize: 18, alignment: .Center)
    ///  子视图添加到父视图时调用该方法
    override func didMoveToSuperview() {
        //addSubView时调用
        print(__FUNCTION__)
    }
    
    ///  它的controller的viewWillAppear执行之后调用
    override func didMoveToWindow() {
        print(__FUNCTION__)
        
        // 添加弹力动画
        addAnimation()
    }
    
    ///  布局子视图. 该方法会调用多次, 系统自动调用. 如果需要手动调用,需要执行layoutIfNeeded
    override func layoutSubviews() {
        print(__FUNCTION__)
    }
    
    init() {
        super.init(frame: screenBounds)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - 设置UI
extension WelcomeView {
    private func setupUI () {
        self.backgroundColor = UIColor.whiteColor()
        
        //1.添加子控件
        addSubview(iconImageView)
        addSubview(welcomeLabel)
        
        //2.自动布局
        iconImageView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-50)
            make.size.equalTo(CGSizeMake(90, 90))
        }
        
        welcomeLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(100)
        }
        
        //让布局立即生效
        layoutIfNeeded()
    }
    
    ///  添加弹力动画
    private func addAnimation () {
        //约束, 第一次创建时,使用的snp_makeConstraints, 第二次修改,则需要使用 snp_updateConstraints, 更新约束,只需要修改, 要修改的值
        iconImageView.snp_updateConstraints { (make) -> Void in
            make.centerY.equalTo(self).offset(-180)
        }
        
        //usingSpringWithDamping: 弹力系数, 从0-1, 越小越弹
        //Velocity 重力系数 9.8
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                //让动画生效
                //该方法会强制调用layoutSubview. 一旦调用layoutSubviews,则约束才会生效
                self.layoutIfNeeded()
            }) { (success) -> Void in
                self.removeFromSuperview()
        }
    }
}































