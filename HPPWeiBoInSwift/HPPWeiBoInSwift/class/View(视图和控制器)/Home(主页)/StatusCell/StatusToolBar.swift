//
//  StatusToolBar.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/17.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit

class StatusToolBar: UIView {
    init() {
        super.init(frame: CGRectZero)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StatusToolBar {
    func setupUI () {
        backgroundColor = UIColor(patternImage: UIImage(named: "timeline_card_bottom_background")!)
        
        let retweetButton = UIButton(title: "30", titleColor:UIColor.grayColor(), fontSize: 10, image: "timeline_icon_retweet")
        let commontButton = UIButton(title: "30", titleColor:UIColor.grayColor(), fontSize: 10, image: "timeline_icon_comment")
        let prizeButton = UIButton(title: "30", titleColor: UIColor.grayColor(), fontSize: 10, image: "timeline_icon_unlike")
        
        let seprateOne: UIImageView = UIImageView(imageName: "timeline_card_bottom_line")
        let seprateTwo: UIImageView = UIImageView(imageName: "timeline_card_bottom_line")
        
        
        addSubview(retweetButton)
        addSubview(commontButton)
        addSubview(prizeButton)
        
        addSubview(seprateOne)
        addSubview(seprateTwo)
        
        retweetButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        commontButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(retweetButton.snp_right)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.equalTo(retweetButton)
        }
        
        prizeButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(commontButton.snp_right)
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.equalTo(commontButton)
        }
        
        seprateOne.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self)
            make.width.equalTo(1)
            make.bottom.equalTo(self)
            make.left.equalTo(retweetButton.snp_right)
        }
        
        seprateTwo.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self)
            make.width.equalTo(1)
            make.bottom.equalTo(self)
            make.left.equalTo(commontButton.snp_right)
        }
        
    }
}






















