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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //login or not
        let isLogIn = false
        if !isLogIn {
            guestView = CHSGuestLogInView()
            //set the delegate to self
            guestView!.delegate = self
            
            view = guestView
        }else {
            //if this code run, means login successfully
            print("登陆成功")
        }
        
    }


    func registButton() {
        print("regist button click")
    }
    
    func logInButton() {
        print("logIn button click")
    }



}
