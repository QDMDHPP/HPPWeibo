//
//  NSBundle+extension.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/13.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import Foundation

let HPPWeiboCurrentVersion = "HPPWeiboCurrentVersion"

extension NSBundle {
    //1.获取当前版本
    class func getCurrentVersion () -> String {
        let version = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        
        return version
    }
    
    //2.比较是否是新版本
    class func isNewVersion() -> Bool {
        //获取当前版本
        let currentVersion = getCurrentVersion()
        
        //获取老版本
        if let oldVersion = NSUserDefaults.standardUserDefaults().objectForKey(HPPWeiboCurrentVersion) as? String {
            saveCurrentVersion()
            return currentVersion != oldVersion
        }
        
        saveCurrentVersion()
        
        return true
    }
    
    //3.存储当前新版本
    class func saveCurrentVersion () {
        //1.取到当前版本
        let currentVersion = getCurrentVersion()
        //2.存起来
        NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: HPPWeiboCurrentVersion)
    }
}



























