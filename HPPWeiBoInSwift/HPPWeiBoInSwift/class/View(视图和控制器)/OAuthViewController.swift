//
//  OAuthViewController.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/11.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit



//let loginSuccessNotification = "HPPloginSuccessNotification"

class OAuthViewController: UIViewController {

    //懒加载属性必须指定类型
    lazy var webView: UIWebView = {
       
        let webView = UIWebView(frame: self.view.bounds)
        webView.delegate = self
        return webView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellowColor()
        
        //添加webView
        view.addSubview(webView)
        
        //加载用户登录页面
        loadLoginPage()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dismissViewControllerAnimated(true, completion: nil)
    }


}

extension OAuthViewController {
    ///  加载用户登录页面
    func loadLoginPage(){
        
        let urlString = NetworkTool.shareTool.loginURL
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        
        webView.loadRequest(request)
    }
    
}

extension OAuthViewController: UIWebViewDelegate {

    //每一个网页对应一个url
    //网页和网页之间可以跳转
    //对每个url对应的网页,如果要让网页显示,就return true, 不想显示, 就return false
    //webView可以截取到每个网页对应的url
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        print(request.URL?.absoluteString)
        
        //如果说url是百度,就说明点击了授权,或者取消按钮,百度不应该显示, return false
        if let urlString = request.URL?.absoluteString where urlString.hasPrefix(redictURI) {
            //代表点击的是授权按钮
            if let query = request.URL?.query where query.hasPrefix("code="){
                //截取code
                if let codeStartIndex = query.rangeOfString("code=")?.endIndex{
                    let code = query.substringFromIndex(codeStartIndex)
                    ///  获取access_token
                    NetworkTool.shareTool.requestAccessToken(code, finish:{(accessTokenResponse) ->() in
                    print(accessTokenResponse)
                        
                        if let accessTokenDic = accessTokenResponse as? [String: AnyObject], uid = accessTokenDic["uid"] as? String, access_token = accessTokenDic["access_token"] as? String{
                            ///  使用access_token和uid获取用户信息
                            NetworkTool.shareTool.requestUserAccount(uid, acces_token: access_token, finish: { (userResponseObject) -> () in
                                print(userResponseObject)
                            })
                        }
                    
                    })
                   
                }
            }else{
                dismissViewControllerAnimated(true, completion: nil)
            }
            return false
        }
        return true
    
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        //网页加载成功
        webView.stringByEvaluatingJavaScriptFromString("document.getElementById('userId').value='\(userName)';document.getElementById('passwd').value='\(passWord)'")
    }
}






















