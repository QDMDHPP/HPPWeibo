//
//  MessageViewController.swift
//  HPPWeiBoInSwift
//
//  Created by 黄晓展 on 16/9/7.
//  Copyright © 2016年 黄晓展. All rights reserved.
//

import UIKit

class MessageViewController: RootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView?.setVistorView("visitordiscover_image_message", title: "在消息页,你可以收到整个世界的消息", isAnimation: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
