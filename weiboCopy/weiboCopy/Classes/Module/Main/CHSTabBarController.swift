//
//  CHSTabBarController.swift
//  weiboCopy
//
//  Created by 王 on 15/12/12.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit

class CHSTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setValue(CHSTabBar(), forKey: "tabBar")
        addChildViewControllers()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //addchildControllers
    private func addChildViewControllers(){
        //use one method to create childViewController one by one
        //change the initial color to orange
        tabBar.tintColor = UIColor.orangeColor()

        //create childViewController
        addChildViewControllerOneByOne(CHSHomeController(), title: "首页", imageName: "tabbar_home")
        addChildViewControllerOneByOne(CHSTMessageController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewControllerOneByOne(CHSDiscoveryController(), title: "发现", imageName: "tabbar_discover")
        addChildViewControllerOneByOne(CHSTProfileController(), title: "个人", imageName: "tabbar_profile")

        
    }
    
    //use one method to create childViewController one by one
    private func addChildViewControllerOneByOne(vc: UIViewController, title: String, imageName: String){
        let navVC = CHSNavController(rootViewController: vc)
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        addChildViewController(navVC)
    }
    

}
