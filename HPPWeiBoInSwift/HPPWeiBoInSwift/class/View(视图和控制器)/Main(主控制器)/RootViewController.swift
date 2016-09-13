//
//  RootViewController.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/7.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit
//MARK: - 属性, 构造函数, 生命周期函数
class RootViewController: UIViewController {
    /// 用户是否登录
    var isLogin: Bool {
        return UserAccount.sharedUserAccount.isLogin
    }
    
     /// tableView的懒加载
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
       
        return tableView
    }()
    
    
    var visitorView: VistorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        
        ///  用户登录成功通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loginSuccess", name: loginSuccessNotification, object: nil)
        
        ///  设置tableView
        setupTableView()
        
        ///  添加访客视图
        setupVisitorView()
    }
    
    deinit {//杀掉通知
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}

// MARK: - 设置UI
extension RootViewController {
    ///  设置tableView
    private func setupTableView() {
        view.addSubview(tableView)
    }
    ///  创建visitorView
    func setupVisitorView (){
        if !isLogin && visitorView == nil {
            visitorView = VistorView()//创建视图
            visitorView?.delegate = self//设置代理
            view.addSubview(visitorView!)//添加视图
        }
        
    }
}



extension RootViewController: VisitorViewDelegate{
    func beginlogin() {
        //显示用户登录页面
        let oAuth = OAuthViewController()
        let oAuthNav = UINavigationController(rootViewController: oAuth)
        presentViewController(oAuthNav, animated: true, completion: nil)
    }
}

extension RootViewController {
    ///  用户登录成功的通知方法实现
    func loginSuccess () {
        visitorView?.removeFromSuperview()
        visitorView = nil
    }
}

// MARK: - 获取数据
extension RootViewController {
    func loadData(){
        
    }
}
// MARK: - 设置TableView数据源
extension RootViewController:UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
// MARK: - UITableViewDelegate
extension RootViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}






























