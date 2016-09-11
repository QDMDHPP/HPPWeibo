//
//  RootViewController.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/7.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    /// 用户是否登录
    var isLogin: Bool {
        return UserAccount.sharedUserAccount.isLogin
    }
    
    var visitorView: VistorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        
        ///  用户登录成功通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loginSuccess", name: loginSuccessNotification, object: nil)
        
        ///  添加访客视图
        setupVisitorView()
    }
    
    deinit {//杀掉通知
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}

extension RootViewController {
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
        print("终于登录成功了")
        visitorView?.removeFromSuperview()
        visitorView = nil
    }
}



































