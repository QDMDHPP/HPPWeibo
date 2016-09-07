//
//  MainViewController.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/7.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit

/// extension的三种用法的回顾
//  1. 扩展类的功能
//  2. 实现协议和代理
//  3. 把实现相同或者相似功能的代码写到一个extension中,让代码逻辑更清晰

// MARK: - 生命周期函数, 属性, 构造函数
class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
}

// MARK: - 设置UI
extension MainViewController {
    /// 设置UI
    func setupUI() {
        //tabBar.tintColor = UIColor.orangeColor()
        addViewControllers()
    }
    
    ///  添加子控制器
    ///
    ///  - parameter controller: 子控制器
    ///  - parameter title:      title
    ///  - parameter imageName:  图片的名字
    func addChildViewController(controller: UIViewController, title: String, imageName: String) {
        controller.title = title
        //需要原图显示
        controller.tabBarItem.image = UIImage(named: imageName)?.imageWithRenderingMode(.AlwaysOriginal)
        controller.tabBarItem.selectedImage = UIImage(named: "\(imageName)_selected")?.imageWithRenderingMode(.AlwaysOriginal)
        
        //文字的颜色(和大小)需要定制
        controller.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.darkGrayColor()], forState: .Normal)
        controller.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.orangeColor()], forState: .Selected)
        
        let navigationController = UINavigationController(rootViewController: controller)
        addChildViewController(navigationController)
    }
    
    /// 添加所有的子控制器
    func addViewControllers () {
        //添加home
        let home = HomeViewController()
        addChildViewController(home, title: "首页", imageName: "tabbar_home")
        
        //添加message
        let message = HomeViewController()
        addChildViewController(message, title: "消息", imageName: "tabbar_message_center")
        
        //添加discover
        let discover = HomeViewController()
        addChildViewController(discover, title: "发现", imageName: "tabbar_discover")
        
        //添加 profile
        let profile = HomeViewController()
        addChildViewController(profile,title: "我", imageName: "tabbar_profile")
    }
 
}




























