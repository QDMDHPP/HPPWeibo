//
//  StatusPictureView.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/16.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit

let cellImageClickNotification = "cellImageClickNotification"

class StatusPictureView: UIView {

    var statusViewModel: StatusViewModel? {
        didSet {
            //把pic_urls对应的图片,加载到StatusPictureView 对应的 imageView上
            for imageView in self.subviews {
                imageView.hidden = true
            }
            
            if let picurls = statusViewModel?.pictureModels{
                
                var index = 0
                
                for pictureModel in picurls {
                    if let ursString = pictureModel.thumbnail_pic {
                        //取到imageView,注意self.subviews[index]取到的类型是UIView,需要强转成UIImageView
                        let imageView = self.subviews[index] as! UIImageView
                        
                        //显示该imageView
                        imageView.hidden = false
                        //给该imageView赋值
                        imageView.setImage(ursString, placeHolder: "avatar_default_big")
                        //index+1,去取下一个imageView
                        index += 1
                        
                        ///  如果只有一张图片
                        if picurls.count == 1 {
                            //在swift中,可以直接更新结构体的属性,更改之后立即生效
                            //在自动布局生效之后,frame的值不一定发生变化
                            //imageView.frame.size = self.bounds.size
                            imageView.frame.size = (statusViewModel?.pictureViewSize)!
                        } else {
                            imageView.frame.size = cellLayout.imageSize
                        }
                    }
                    
                    //如果有四张图片,当取到第三个imageView的时候,跳过该imageView
                    if index == 2 && picurls.count == 4 {
                        index += 1
                    }
                }
            }
        }
    }
    
    init () {
        super.init(frame: CGRectZero)
    
        setupUI()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StatusPictureView {
    func setupUI () {
        backgroundColor = UIColor.greenColor()
        
        //加9张图片
        for i in 0..<9 {
            let row = i/3
            let col = i%3
            let stepx: CGFloat = CGFloat(col) * (cellLayout.imageHeight + cellLayout.margin)
            let stepy: CGFloat = CGFloat(row) * (cellLayout.imageHeight + cellLayout.margin)
            let imageRect = CGRectOffset(CGRect(origin: CGPointZero, size: cellLayout.imageSize), stepx, stepy)
            let imageView = UIImageView(frame: imageRect)
            
            imageView.userInteractionEnabled = true
            imageView.contentMode = .ScaleAspectFill
            imageView.clipsToBounds = true
            imageView.backgroundColor = UIColor.redColor()
            imageView.tag = i
            addSubview(imageView)
            
            let tap = UITapGestureRecognizer(target: self, action: "imageClick:")
            imageView.addGestureRecognizer(tap)
            
            //子视图超出父视图的frame时,把超出的部分切掉
            self.clipsToBounds = true
        }
    }
}

extension StatusPictureView {
    @objc private func imageClick (tap: UITapGestureRecognizer) {
        //获取点击的是第几张图片
        var index = (tap.view?.tag)!
        
        if let count = statusViewModel?.pictureModels.count where count == 4 && index > 2{
            index -= 1
        }
        
        //获取当前所有图片的url
        var urls: [String] = []
        
        guard let pictureModel = statusViewModel?.pictureModels else {
            return
        }
        
        urls = (pictureModel as NSArray).valueForKey("thumbnail_pic") as! [String]
        
        let userInfo = ["currentIndex": index, "urls":urls]
        
        let notification = NSNotification(name:cellImageClickNotification , object: nil, userInfo: userInfo as [NSObject : AnyObject])
        
        NSNotificationCenter.defaultCenter().postNotification(notification)
        
    }
}














