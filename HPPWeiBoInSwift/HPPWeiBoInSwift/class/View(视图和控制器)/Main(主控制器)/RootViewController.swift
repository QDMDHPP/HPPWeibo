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
        
        setupVisitorView()
    }

   
}

extension RootViewController {
    
    func setupVisitorView (){
        if !isLogin && visitorView == nil {
            visitorView = VistorView()
            view.addSubview(visitorView!)
        }
        
    }
}

















