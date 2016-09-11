//
//  RootViewController.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/7.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    var isLogin: Bool = false
    
    var visitorView: VistorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        

        
        ///  添加访客视图
        setupVisitorView()
    }


}

extension RootViewController {
    
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





































