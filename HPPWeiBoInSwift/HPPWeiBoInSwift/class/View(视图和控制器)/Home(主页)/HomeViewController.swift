//
//  HomeViewController.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/7.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit

private let identifier = "cell"

class HomeViewController: RootViewController {

    ///  数据源
    lazy var statusArray: [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置tableView
        setupTableView()
        
        //设置visitorView
        visitorView?.setVistorView("visitordiscover_feed_image_house", title: "在首页,你可以追星,看段子,看美女和帅哥", isAnimation: true)
    }

}

extension HomeViewController {
    func setupTableView () {
        //1. registClass
        tableView.registerClass(StatusCell.self, forCellReuseIdentifier: identifier)
        
        //tableView自适应行高,必须设置这两个属性
        //预估行高: 用预估行高先去计算一个contentsize. 让tableView能够滚动.所以 预估行高 要尽量接近真实行高
        tableView.estimatedRowHeight = 400
        //设置该属性, 在滚动的过程中可以动态计算并调整contensize
        tableView.rowHeight = UITableViewAutomaticDimension
    }
}

//MARK: - UITableViewDataSource
extension HomeViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        return cell
    }
}

















