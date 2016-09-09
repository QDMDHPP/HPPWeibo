//
//  VistorView.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/8.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit
import SnapKit

//MARK: - 创建一个UIView的子类
class VistorView: UIView {

    /// 大图标
    lazy var iconImage: UIImageView = UIImageView(imageName: "visitordiscover_feed_image_house")

    ///  菊花
    lazy var circleImage: UIImageView = UIImageView(imageName: "visitordiscover_feed_image_smallicon")
    
    ///  遮罩
    lazy var shadowImage: UIImageView = UIImageView(imageName: "visitordiscover_feed_mask_smallicon")
    
    /// 提示文字
    lazy var textLabel: UILabel = UILabel(title: "在首页,你可以追星,看黄段子,看美女",fontSize: 14, alignment: .Center)
    
    
    ///  注册按钮
    lazy var registButton: UIButton = UIButton(title: "注册", titleColor:globalColor, fontSize: 14, backgroundImage: "tabbar_compose_button", target: self, action: "regist" )
    
    
    ///  登录按钮
    lazy var loginButton: UIButton = UIButton(title: "登录", titleColor: UIColor.darkGrayColor(), fontSize: 14, backgroundImage: "common_button_white_disable", target: self, action: "regist")
    
    init() {
        super.init(frame: screenBounds)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension VistorView {
///  设置UI: 顺序是从上到下,从左到右
    func setupUI () {
        
        //设置了背景颜色
        self.backgroundColor = UIColor(white: 237/255.0 , alpha: 1.0)
        
        //1.添加子视图
        addSubview(iconImage)
        addSubview(circleImage)
        addSubview(shadowImage)
        addSubview(textLabel)
        addSubview(registButton)
        addSubview(loginButton)
        
        //2. 自动布局的规则: 从上到下,从左到右. 当控件比较多时,添加一个控件,就要运行一下看看效果
        //snapKit的用法
        //make.centerY.equalTo(circleImage).offset(150)
        
        //图标
        iconImage.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-100)
        }
        
        //菊花
        circleImage.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconImage)
            make.centerY.equalTo(iconImage).offset(5)
        }
        
        //遮罩
        shadowImage.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(circleImage)
            make.centerY.equalTo(circleImage).offset(50)
            make.left.right.equalTo(self)
        }
        
        //文字
        textLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.centerY.equalTo(circleImage).offset(150)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
        }
        
        //注册按钮
        registButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(70)
            make.bottom.equalTo(self).offset(-150)
            make.width.equalTo(80)
            make.height.equalTo(35)
        }
        
        //登录按钮
        loginButton.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(self).offset(-70)
            make.bottom.equalTo(registButton)
            make.size.equalTo(registButton)
        }
        
        //添加动画
        addAnimation()
    }

    
    func addAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = 2 * M_PI
        animation.repeatCount = MAXFLOAT
        animation.duration = 10
        animation.removedOnCompletion = false
        
        circleImage.layer.addAnimation(animation, forKey: nil)
    }

    /// 设置visitorView
    func setVistorView(image: String, title: String, isAnimation: Bool) {
        iconImage.image = UIImage(named: image)
        textLabel.text = title
        circleImage.hidden = !isAnimation
    }

}























