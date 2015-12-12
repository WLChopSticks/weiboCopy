//
//  CHSTabBar.swift
//  weiboCopy
//
//  Created by 王 on 15/12/12.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit

class CHSTabBar: UITabBar {
    
    //define some common frame
    let kScreenBounds = UIScreen.mainScreen().bounds
    let kScreenWidth = UIScreen.mainScreen().bounds.width
    let kScreenHeight = UIScreen.mainScreen().bounds.height
    

    //when we override initWithFrame method, it means we will create the view by code not by the xib
    override init(frame: CGRect) {
        //use method super first
        super.init(frame: frame)
        //put the compose button on the tabbar
        addSubview(composeBtn)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //override layoutSubview method to change the frame of the barbuttonItems
    override func layoutSubviews() {
        super.layoutSubviews()
        //calculate the frames
        let w = bounds.width / 5
        let h = bounds.height
        //define a number to make the third item in the forth place
        var index: CGFloat = 0
        for view in subviews{
            
            if view.isKindOfClass(NSClassFromString("UITabBarButton")!){
                print(view)
                if index == 2 {
                    composeBtn.frame = CGRectMake(index * w, 0, w, h)
                    index++
//                    continue
                }
                print(index)
                view.frame = CGRectMake(index * w, 0, w, h)
                index++
//                print(view.frame)

            }
            
        }
        
    }
    
    
    //create the composeButton which is in the center
    lazy var composeBtn: UIButton = {
        let btn = UIButton()
        //set image and background for the button
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
        btn.sizeToFit()
        
        return btn
    }()

}
