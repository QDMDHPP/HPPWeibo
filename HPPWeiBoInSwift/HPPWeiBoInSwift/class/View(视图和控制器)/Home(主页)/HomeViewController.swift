//
//  HomeViewController.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/7.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit
import YYModel

private let identifier = "cell"

class HomeViewController: RootViewController {

    ///  数据源
    lazy var statusViewModelArray: [StatusViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置tableView
        setupTableView()
        
        //获取微博首页的数据
        loadData()
        
        //设置visitorView
        visitorView?.setVistorView("visitordiscover_feed_image_house", title: "在首页,你可以追星,看段子,看美女和帅哥", isAnimation: true)
    }

}

extension HomeViewController {
    override func loadData() {
        //下拉刷新传since_id
        var since_id: UInt64 = 0
        //上拉刷新传max_id
        var max_id: UInt64 = 0
        
        //说明是下拉刷新
        let isPullDown = refreshHeader.isRefreshing()
        
        if isPullDown {
            refreshHeader.beginRefreshing()
            since_id = statusViewModelArray.first?.statusModel.id ?? 0
        } else {
            refreshFooter.beginRefreshing()
            max_id = statusViewModelArray.first?.statusModel.id ?? 0
        }
        
        if let accessToken = UserAccount.sharedUserAccount.access_token {
            //请求首页的微博数据
            NetworkTool.shareTool.requestStatus(since_id, max_id: max_id, acces_token: accessToken, finish: { (responseObject) -> () in
                
                let responseDict = (responseObject as? [String: AnyObject])
                let statusObject = responseDict?["statuses"]
                
                if let statusDictArray = statusObject as? [[String: AnyObject]] {
                    //创建一个空数组,用来装从服务器返回获取的 model
                    var responseStatusViewModelArray: [StatusViewModel] = []
                    
                    for statusDict in statusDictArray {
                        if let statusModel = StatusModel.yy_modelWithJSON(statusDict) {
                        
                            print(statusModel)
                            //处理statusModel的一些属性,比如说创建日期, 来源, 用户的头像等等
                            let statusViewModel = StatusViewModel(statusModel: statusModel)
                            responseStatusViewModelArray.append(statusViewModel)
                        }
                    }
                    
                    if isPullDown {
                        self.statusViewModelArray = responseStatusViewModelArray + self.statusViewModelArray
                        self.refreshHeader.endRefreshing()
                    } else {
                        //判断一下是否是第一次
                        if max_id > 0 {
                            responseStatusViewModelArray.removeFirst()
                        }
                        
                        self.statusViewModelArray += responseStatusViewModelArray
                        self.refreshFooter.endRefreshing()
                    }
                    
                    self.tableView.reloadData()
                }
            })
        }
    }
}


extension HomeViewController {
    override func setupTableView () {
        super.setupTableView()
        //1. registClass
        tableView.registerClass(StatusCell.self, forCellReuseIdentifier: identifier)
        
        //tableView自适应行高,必须设置这两个属性
        //预估行高: 用预估行高先去计算一个contentsize. 让tableView能够滚动.所以 预估行高 要尽量接近真实行高
        tableView.estimatedRowHeight = 400
        //设置该属性, 在滚动的过程中可以动态计算并调整contensize
        tableView.rowHeight = UITableViewAutomaticDimension
        //取消分割线
        tableView.separatorStyle = .None
    }
}

//MARK: - UITableViewDataSource
extension HomeViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusViewModelArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! StatusCell
        let statusViewModel = statusViewModelArray[indexPath.row]
        cell.statusViewModel = statusViewModel
        
        return cell
    }
}

















