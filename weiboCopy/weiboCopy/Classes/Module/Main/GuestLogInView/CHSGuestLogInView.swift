//
//  CHSGuestLogInView.swift
//  weiboCopy
//
//  Created by 王 on 15/12/13.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit

@objc protocol guestLogInViewDelegate: NSObjectProtocol {
    func logInButton()
    func registButton()
    
}

class CHSGuestLogInView: UIView {
    
    //set the delegate
    weak var delegate: guestLogInViewDelegate?

    //make view add those controls, override initWithFrame method
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(circle)
        addSubview(cover)
        addSubview(regist)
        addSubview(logIn)
        addSubview(house)
        addSubview(infoLabel)

        //add target fot the two buttons
        regist.addTarget(self, action: Selector("registButtonClicking"), forControlEvents: .TouchUpInside)
        logIn.addTarget(self, action: "logInButtonClicking", forControlEvents: .TouchUpInside)

        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
     func setUpThePages(info: String, imageNmae: String?) {
        infoLabel.text = info
        if let name = imageNmae {
            //it's not the home page
            house.hidden = true
            circle.image = UIImage(named: name)
            bringSubviewToFront(circle)
        }else{
            //it's the home page
            decorateTheHomePage()

        }
    }
    
    //the regist button click method
    @objc private func registButtonClicking() {
        delegate?.registButton()
    }
    
    //the logIn button click method
    @objc private func logInButtonClicking() {
        delegate?.logInButton()
    }
    
    //the circle image animation
    private func decorateTheHomePage() {
        //set the animation
        let ani = CABasicAnimation(keyPath: "transform.rotation")
        ani.repeatCount = MAXFLOAT
        ani.duration = 10
        ani.toValue = 2 * M_PI
        
        ani.removedOnCompletion = false
        circle.layer.addAnimation(ani, forKey: nil)
    }
    
    override func layoutSubviews() {
        
        //add constraints for those controls
        for subview in subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        //house image constraints
        addConstraint(NSLayoutConstraint(item: house, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: house, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: -70))
        
        //circle image constraints
        addConstraint(NSLayoutConstraint(item: circle, attribute: .CenterX, relatedBy: .Equal, toItem: house, attribute: .CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: circle, attribute: .CenterY, relatedBy: .Equal, toItem: house, attribute: .CenterY, multiplier: 1, constant: 0))
        
        //infoLabel constraints, because label maybe have many lines,so we also need to set its width. no need to set height
        addConstraint(NSLayoutConstraint(item: infoLabel, attribute: .CenterX, relatedBy: .Equal, toItem: circle, attribute: .CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: infoLabel, attribute: .Top, relatedBy: .Equal, toItem: circle, attribute: .Bottom, multiplier: 1, constant: 10))
        addConstraint((NSLayoutConstraint(item: infoLabel, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1, constant: 200)))

        //two buttons constraints
        //logIn button
        addConstraint(NSLayoutConstraint(item: logIn, attribute: .Left, relatedBy: .Equal, toItem: infoLabel, attribute: .Left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: logIn, attribute: .Top, relatedBy: .Equal, toItem: infoLabel, attribute: .Bottom, multiplier: 1, constant: 20))

        addConstraint(NSLayoutConstraint(item: logIn, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 85))
        addConstraint(NSLayoutConstraint(item: logIn, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 35))
        //regist button
        addConstraint(NSLayoutConstraint(item: regist, attribute: .Right, relatedBy: .Equal, toItem: infoLabel, attribute: .Right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: regist, attribute: .Top, relatedBy: .Equal, toItem: infoLabel, attribute: .Bottom, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: regist, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 85))
        addConstraint(NSLayoutConstraint(item: regist, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 35))
        
        //cover constraint
        //it's not good to set a whole background with it
//        addConstraint(NSLayoutConstraint(item: cover, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: -550))
//        addConstraint(NSLayoutConstraint(item: cover, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: cover, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: cover, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1, constant: 0))
        //just use this image cover a part of the screen where the circle image is
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[cover]-0-|", options: [], metrics: nil, views: ["cover" : cover]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[cover]-(40)-[regist]", options: [], metrics: nil, views: ["cover" : cover, "regist" : regist]))
        //set the background color, the same as the cover image
        backgroundColor = UIColor(white: 0.93, alpha: 1)
        

    }

    
    
    //use lazy loading to create these control
    //decorate the home page, including two buttons and two imageviews
    private lazy var house = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    private lazy var circle = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    //lazy loading actually is closture
    private lazy var regist: UIButton = {
        let btn = UIButton()
        btn.setTitle("注册", forState: .Normal)
        btn.setTitleColor(themeColor, forState: .Normal)
        let btnImage2 = UIImage(named: "common_button_white_disable")
        //use resizableImageWithCapInsets method to change the image size and dont change the shape
        let btnImage = btnImage2?.resizableImageWithCapInsets(UIEdgeInsetsMake((btnImage2?.size.height)! * 0.5, (btnImage2?.size.width)! * 0.5, (btnImage2?.size.height)! * 0.5, (btnImage2?.size.width)! * 0.5))
        btn.setBackgroundImage(btnImage, forState: .Normal)
    
        return btn
        
    }()
    
    private lazy var logIn: UIButton = {
    
        let btn = UIButton()
        btn.setTitle("登陆", forState: .Normal)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        let btnImage2 = UIImage(named: "common_button_white_disable")
        let btnImage = btnImage2?.resizableImageWithCapInsets(UIEdgeInsetsMake((btnImage2?.size.height)! * 0.5, (btnImage2?.size.width)! * 0.5, (btnImage2?.size.height)! * 0.5, (btnImage2?.size.width)! * 0.5))
        btn.setBackgroundImage(btnImage, forState: .Normal)
        
        return btn
    
    }()
    
    //declaration the info label
    private lazy var infoLabel: UILabel = {
        let info = UILabel()
        info.font = UIFont.systemFontOfSize(14)
        info.textAlignment = .Center
        info.numberOfLines = 0
        info.textColor = UIColor.darkGrayColor()
        info.text = ""
        return info
    }()
    
    //use an image to cove a part of the circle
    private lazy var cover = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    

}
