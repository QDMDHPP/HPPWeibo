//
//  NewFeatureView.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/13.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit


//MARK: - 属性, 构造函数, 生命周期函数
class NewFeatureView: UIView {

    ///  scrollView
    private lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView(frame: screenBounds)
        scrollView.bounces = false
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.clearColor()
        return scrollView
    }()
    
    ///  pageControl
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = UIColor.blackColor()
        pageControl.currentPageIndicatorTintColor = globalColor
        pageControl.currentPage = 0
        pageControl.numberOfPages = 4
        pageControl.userInteractionEnabled = false
        return pageControl
    }()

    init() {
        super.init(frame:screenBounds)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 设置UI
extension NewFeatureView {
    private func setupUI () {
        backgroundColor = UIColor.clearColor()
        
        //1. 添加子控件
        addSubview(scrollView)
        addSubview(pageControl)
        
        //2. 设置子控件
        //设置scrollView
        for i in 1...4 {
            let imageView = UIImageView(imageName: "new_feature_\(i)")
            imageView.frame = CGRect(origin: CGPointMake(screenWidth*CGFloat(i-1), 0), size: screenBounds.size)
            print(imageView.frame)
            scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSizeMake(screenWidth*5, 0)
        
        //3. 自动布局 
        pageControl.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-100)
            
        }
    }
}

// MARK: - UIScrollViewDelegate
extension NewFeatureView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //scrollView滑动到屏幕的中间位置, 更改 pageControl的值
        let offsetx = scrollView.contentOffset.x
        
        //四色五人,要记住 Int(小数 + 0.5)
        //分页算法 (总页数 - 1) / 每页显示的个数 + 1
        //更改pageControl的值
        let currentPage = Int (offsetx / screenWidth + 0.5)
        pageControl.currentPage = currentPage
        
        //当所有的imageView都显示完了就隐藏pageControl
        pageControl.hidden = offsetx > (screenWidth * 3 + 100)
        
        //释放新功能页
        if offsetx >= screenWidth * 4 {
            self.removeFromSuperview()
        }
    }
}























