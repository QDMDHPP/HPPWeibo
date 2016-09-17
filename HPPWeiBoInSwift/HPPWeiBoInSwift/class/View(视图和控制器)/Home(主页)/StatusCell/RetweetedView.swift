//
//  RetweetedView.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/16.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit

class RetweetedView: UIView {

    //视图模型
    var statusViewModel: StatusViewModel? {
        didSet {
            //给pictureView设置数据
            pictureView.statusViewModel = statusViewModel
            
            //设置转发微博的文字
            retweetedLabel.text = statusViewModel?.retweetedText
            
            /// 判断是否有转发微博
            if let retweetedModel = statusViewModel?.statusModel.retweeted_status {
                //如果有转发微博, 则一定有文字, 转发微博的文字的top一定要设置
                retweetedLabel.snp_updateConstraints { (make) -> Void in
                    make.top.equalTo(self).offset(cellLayout.margin)
                }
                //如果有图片
                if let pictureModels = retweetedModel.pic_urls where pictureModels.count > 0 {
                    pictureView.snp_updateConstraints { (make) -> Void in
                        make.top.equalTo(retweetedLabel.snp_bottom).offset(cellLayout.margin)
                        make.size.equalTo((statusViewModel?.pictureViewSize)!)
                        make.bottom.equalTo(self).offset(-cellLayout.margin)
                    }
                }
                //如果没有图片
                else {
                    pictureView.snp_updateConstraints { (make) -> Void in
                        make.top.equalTo(retweetedLabel.snp_bottom)
                        make.size.equalTo(CGSizeZero)
                        //保证文字和底部有一个margin的间距
                        make.bottom.equalTo(self).offset(-cellLayout.margin)
                    }
                }
            }
            //没有转发微博
            else {
                retweetedLabel.snp_updateConstraints { (make) -> Void in
                    make.top.equalTo(self)
                }
                
                pictureView.snp_updateConstraints { (make) -> Void in
                    make.top.equalTo(retweetedLabel.snp_bottom)
                    make.size.equalTo(CGSizeZero)
                    //扎袋口
                    make.bottom.equalTo(self)
                }
            }
        }
    }
    
    ///  转发微博的文本
    let retweetedLabel: UILabel = UILabel(title:nil, fontSize: 15)
    
    ///  配图视图
    let pictureView: StatusPictureView = StatusPictureView()

    init() {
        super.init(frame:CGRectZero)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RetweetedView {
    func setupUI () {
        
        backgroundColor = superview?.backgroundColor
        
        //1. 添加子控件
        addSubview(retweetedLabel)
        addSubview(pictureView)
        
        //2.设置子控件
//        let randomCount = random() % 20 + 1
//        var string = "呵呵呵,我笑了"
//        for _ in 0..<randomCount {
//            string.appendContentsOf("笑得哈哈哈")
//        }
//        
//        retweetedLabel.text = string
        
        pictureView.backgroundColor = UIColor.redColor()

        //3. 自动布局
        retweetedLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(cellLayout.margin)
            make.right.equalTo(self).offset(-cellLayout.margin)
            make.top.equalTo(self).offset(cellLayout.margin)
        }
        
        pictureView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(retweetedLabel.snp_bottom).offset(cellLayout.margin)
            make.left.equalTo(retweetedLabel)
            make.size.equalTo(CGSizeZero)
            //扎口袋
            make.bottom.equalTo(self).offset(-cellLayout.margin)
        }
    }
}


















