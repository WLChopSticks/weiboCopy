//
//  CHSBaseViewController.swift
//  weiboCopy
//
//  Created by 王 on 15/12/13.
//  Copyright © 2015年 王. All rights reserved.
//  

/**

This class is based class, the other four controllers inherit this class
To judge if the user logIn the system, if not get into guest view, otherwise, get into the weibo

*/


import UIKit

class CHSBaseViewController: UITableViewController, guestLogInViewDelegate {
    
    //set guestView
    var guestView: CHSGuestLogInView?
//     var visitorLoginView: VisitorLoginView?
    

    override func loadView() {
        let userLogIn = CHSUserAccountViewModel().userLogIn
        print(userLogIn)
        
        //login or not
        let isLogIn = userLogIn
        if !isLogIn {
            guestView = CHSGuestLogInView()
            //set the delegate to self
            guestView!.delegate = self
            
            //add two buttons on the left and right corner
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "登陆", style: .Plain, target: self, action: "logInButton")
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: "registButton")
            
            
            view = guestView
        }else {
            //if this code run, means login successfully
            super.loadView()
            print("登陆成功")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }


    func registButton() {
        print("regist button click")
    }
    
    func logInButton() {
        print("logIn button click")
        //modal a controller to show the logIn information
        let logInView = CHSLogInViewController()
        let oAuth = CHSNavController(rootViewController: logInView)

        presentViewController(oAuth, animated: true, completion: nil)
    }



}
