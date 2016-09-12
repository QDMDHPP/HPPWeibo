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
    
    //发布按钮,只创建一次,并且在第一次调用是创建
    lazy var composeButton: UIButton = {
        let button = UIButton(title: nil,image: "tabbar_compose_icon_add", backgroundImage: "tabbar_compose_button", target: self, action: "compose")
       return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //更新UI
        setupUI()
    
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //tabBar的item并不是在viewDidLoad中创建的,所以需要将发布按钮的创建写在viewWillAppear里面
        addComposeButton()
        
    }
}

// MARK: - 设置UI
extension MainViewController {
    /// 设置UI
    func setupUI() {
        //tabBar.tintColor = UIColor.orangeColor()
        //添加控制器
        addViewControllers()
        //添加tabbar的效果线
        cetTabbarLine()
        //添加新功能也或者欢迎页
        if UserAccount.sharedUserAccount.isLogin {
            addNewFeatureOrWelcomeView()
        }
    }
    
    ///  添加子控制器
    ///
    ///  - parameter controller: 子控制器
    ///  - parameter title:      title
    ///  - parameter imageName:  图片的名字
    func addChildViewController(controller: UIViewController, title: String, imageName: String?) {
        controller.title = title
        
        if let imageName = imageName {
        
            //需要原图显示
            controller.tabBarItem.image = UIImage(named: imageName)?.imageWithRenderingMode(.AlwaysOriginal)
            controller.tabBarItem.selectedImage = UIImage(named: "\(imageName)_selected")?.imageWithRenderingMode(.AlwaysOriginal)
        }
       
        
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
        let message = MessageViewController()
        addChildViewController(message, title: "消息", imageName: "tabbar_message_center")
        
        //添加占位tabBarItem
        let setUp = UIViewController()
        addChildViewController(setUp, title: "", imageName:nil)
        
        //添加discover
        let discover = DiscoverViewController()
        addChildViewController(discover, title: "发现", imageName: "tabbar_discover")
        
        //添加 profile
        let profile = ProfileViewController()
        addChildViewController(profile,title: "我", imageName: "tabbar_profile")
    }
    
    func addComposeButton () {
        //设置button位置的第一种方式
        //button.center = CGPointMake(screenWidth*0.5, screenHeight*0.5)
        
        //第二种方法
        //CGRectInset: 以某一个Rect为基础, 向内向外, 对称缩放
        composeButton.frame = CGRectInset(tabBar.bounds, screenWidth/5*2, 3)
        
        //将button添加到tabbar
        tabBar.addSubview(composeButton)
    }
    
    func cetTabbarLine () {
        //如果希望修改tabbar那条件,需要设以下两个属性
        tabBar.backgroundImage = UIImage(named: "tabbar_background")
        //用代码去创建一张纯色的图片
        tabBar.shadowImage = UIImage.creatImage(CGSizeMake(1, 1), color: UIColor(white: 0.9, alpha: 1.0))
    }
 
    // MARK: - 添加新特性页或者是欢迎页
    private func addNewFeatureOrWelcomeView () {
        //如果判断是否有新功能?
        //1.比对当前版本和之前版本是否一致
        //2.怎么获取当前版本, 现有的api
        //3.怎么获取之前版本: 每一次安装之后,要把当前版本存在本地
        //4.以上的事儿,谁来做?是否可以封装一下.单一职能原则. NSBundel
        
        //如果有新特性
        if NSBundle.isNewVersion() {
            //显示新特性页
            let newFeature = NewFeatureView()
            view.addSubview(newFeature)
        }else{
            //显示欢迎页
            let welcome = WelcomeView()
            view.addSubview(welcome)
        }
    }
}

//MARK: - 事件处理
extension MainViewController {
    
    func compose () {
        print("发布.....")
    }
}









































