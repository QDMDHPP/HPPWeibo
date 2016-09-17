//
//  StatusCell.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/15.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit

class StatusCell: UITableViewCell {
    
    var statusViewModel: StatusViewModel? {
        didSet {
            originalView.statusViewModel = statusViewModel
            retweetedView.statusViewModel = statusViewModel
        }
    }
    
    /// 原创微博
    lazy var originalView: OriginalView = OriginalView()
    
    /// 转发微博
    let retweetedView: RetweetedView = RetweetedView()
    
    /// toobar
    let toolBar: StatusToolBar = StatusToolBar()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension StatusCell {
    func setupUI () {
        
        contentView.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        
        //1. 添加子视图
        contentView.addSubview(originalView)
        contentView.addSubview(retweetedView)
        contentView.addSubview(toolBar)
        
        //2. 自动布局
        originalView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.top.equalTo(contentView).offset(5)
        }
        
        retweetedView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.top.equalTo(originalView.snp_bottom)
        }
        
        toolBar.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.top.equalTo(retweetedView.snp_bottom)
            make.height.equalTo(36)
        }
        
        contentView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(toolBar)
        }
    }
}























