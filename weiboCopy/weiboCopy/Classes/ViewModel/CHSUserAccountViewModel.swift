//
//  CHSUserAccountViewModel.swift
//  weiboCopy
//
//  Created by 王 on 15/12/15.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit
import AFNetworking

class CHSUserAccountViewModel: NSObject {

    var userAccount: CHSAccountInfo?
    override init() {
        userAccount = CHSAccountInfo.loadUserData()
        super.init()
    }
    
    var userLogIn: Bool {
        return userAccount?.access_token != nil
    }
    
    
    
    //get access tocken
    func getAccessTocken(code: String, finish: (userLogIn:Bool) -> ()) {
        
        let parameter = ["client_id":"235072683","client_secret":"78ccdeaf1013c97ed69804b87dba2fc9","grant_type":"authorization_code","code":code,"redirect_uri":callBackURL]
        
        let manager = AFHTTPSessionManager()
        
        manager.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        manager.POST("https://api.weibo.com/oauth2/access_token", parameters: parameter, success: { (_, result) -> Void in
            //            print("--------------------")
            //            print(result)
            //here, dictionary -> model
            let user = CHSAccountInfo(dict: result as! [String : AnyObject])
            self.getUserData(user, finish: finish)
            
            
            }) { (_, error) -> Void in
                print(error)
                finish(userLogIn: false)
        }
    }
    
    //send the access_token and get the user's data
    func getUserData(user: CHSAccountInfo, finish: (userLogIn:Bool) -> ()) {
        
        //        send the access_tocken which we get and get the user's data
        
        let urlString = "https://api.weibo.com/2/users/show.json?" + "access_token=" + "\(user.access_token!)" + "&uid=" + "\(user.uid!)"
        let manager = AFHTTPSessionManager()
        
        manager.GET(urlString, parameters: nil, success: { (_, result) -> Void in
            //logIn successfully, and can deliver message to controller to close this modal viewcontroller
//            self.returnToTheMainView()
            //get the user data
            
            let avatar_large = result["avatar_large"] as! String
            let name = result["name"] as! String
            
            
            user.name = name
            user.avatar_large = avatar_large
            //save user data
            user.saveUserData()
            
            finish(userLogIn: true)
            }) { (_, error) -> Void in
                print(error)
                finish(userLogIn: false)
        }
        
    }

}
