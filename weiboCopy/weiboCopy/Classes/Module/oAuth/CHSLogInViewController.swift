//
//  CHSLogInViewController.swift
//  weiboCopy
//
//  Created by 王 on 15/12/14.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit
import AFNetworking

class CHSLogInViewController: UIViewController, UIWebViewDelegate {

    
    let webView = UIWebView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //change the view to the webView to show the oAhtu information
        view = webView
        
        //add a reurn button
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .Plain, target: self, action: "returnToTheMainView")
        //add an autofill button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填写", style: .Plain, target: self, action: "autoFillButton")
        
        //webView delegate
        webView.delegate = self
        
        
        //load the autho view
        loadAuthoView()

    }
    
    private func loadAuthoView() {
        
        let url = NSURL(string: "https://api.weibo.com/oauth2/authorize" + "?client_id=" + "235072683" + "&redirect_uri=" + callBackURL)
        let urlRequest = NSURLRequest(URL: url!)
        webView.loadRequest(urlRequest)
        
    }
    
    //return and autofill button method
    @objc private func autoFillButton() {
        let autofill = "document.getElementById('userId').value = '18602602808' ,document.getElementById('passwd').value = '1357924680'"
        webView.stringByEvaluatingJavaScriptFromString(autofill)
    }

    @objc private func returnToTheMainView() {
        dismissViewControllerAnimated(true, completion: nil)
        
    }

    
    //realize delegate method
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
//        print(request.URL?.absoluteString)
        
        //shield some unuseful web, eg.regist button and change account choice
        guard let urlString = request.URL?.absoluteString else {
            return false
        }
        if urlString.hasPrefix("http://weibo.cn/dpool/ttt/h5/reg.php") {
            return false
        }
        if urlString.hasPrefix("http://passport.sina.cn/sso/crossdomain") {
            return false
        }
        if urlString.hasPrefix("https://api.weibo.com/oauth2/") {
            return true
        }
        if urlString.hasPrefix("https://m.baidu.com/") {
            return false
        }
        
        //http://www.weibo.com/yes603020460?code=972944fad66aee898b8bfc296355e804&is_all=1
        //get the code from the call back url
        let query = request.URL?.query
        if let q = query {

            let pre = "code="
            let code = q.substringFromIndex(pre.endIndex)

            CHSUserAccountViewModel().getAccessTocken(code, finish: { (userLogIn) -> () in
                if userLogIn {
                    print("success")
                    self.returnToTheMainView()
                    
                }else {
                    print("fail to load")
                }
            })
        
        }
        return true
    }
    
    


}
