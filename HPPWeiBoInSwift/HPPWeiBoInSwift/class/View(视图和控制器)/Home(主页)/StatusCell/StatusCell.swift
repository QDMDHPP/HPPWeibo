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
        }
    }
    
    /// 原创微博
    lazy var originalView: OriginalView = OriginalView()
    
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
        //1. 添加子视图
        contentView.addSubview(originalView)
        
        //2. 自动布局
        originalView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.top.equalTo(contentView)
        }
        
        contentView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(originalView)
        }
    }
}























