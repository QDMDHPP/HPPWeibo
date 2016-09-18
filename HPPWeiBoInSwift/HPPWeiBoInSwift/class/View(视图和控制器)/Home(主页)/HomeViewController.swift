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

    ///  viewModel
    lazy var statutListViewModel: StatusListViewModel = StatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置tableView
        setupTableView()
        
        //获取微博首页的数据
        loadData()
        
        //设置visitorView
        visitorView?.setVistorView("visitordiscover_feed_image_house", title: "在首页,你可以追星,看段子,看美女和帅哥", isAnimation: true)
        
        //点击cell中的图片的通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "cellImageClick:", name: cellImageClickNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}

extension HomeViewController {
    func cellImageClick(notification: NSNotification){
        print("=======\(notification.userInfo)")
    }
}

extension HomeViewController {
    override func loadData() {
        //说明是下拉刷新
        let isPullDown = refreshHeader.isRefreshing()
        
        if isPullDown {
            refreshHeader.beginRefreshing()
        } else {
            refreshFooter.beginRefreshing()
        }
        
        statutListViewModel.loadStatus(isPullDown) { (success) -> () in
            //请求完成后,不管是成功,还是失败,都需要停止刷新
            if isPullDown {
                self.refreshHeader.endRefreshing()
            } else {
                self.refreshFooter.endRefreshing()
            }
            
            ///  如果成功加载数据,就reloadTableView
            if success {
                self.tableView.reloadData()
            }
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
//        tableView.estimatedRowHeight = 400
        //设置该属性, 在滚动的过程中可以动态计算并调整contensize
//        tableView.rowHeight = UITableViewAutomaticDimension
        //取消分割线
        tableView.separatorStyle = .None
    }
}

//MARK: - UITableViewDataSource
extension HomeViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statutListViewModel.statusViewModelArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! StatusCell
        cell.selectionStyle = .None
        let statusViewModel = statutListViewModel.statusViewModelArray[indexPath.row]
        cell.statusViewModel = statusViewModel
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let statusViewModel = statutListViewModel.statusViewModelArray[indexPath.row]
        
        return statusViewModel.rowHeight

    }
    
   
}

















