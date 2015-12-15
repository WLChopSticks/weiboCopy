//
//  CHSAccountInfo.swift
//  weiboCopy
//
//  Created by 王 on 15/12/14.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit

class CHSAccountInfo: NSObject, NSCoding {

    var access_token: String?
    var expires_in: NSTimeInterval = 0 {
        didSet {
            //calculate the time and jadge if we can login autoly
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    var remind_in: String?
    var uid: String?
    var expires_date: NSDate?
    
    
    var name: String?
    var avatar_large: String?
    
    init(dict: [String : AnyObject]) {
        super.init()
        self.setValuesForKeysWithDictionary(dict)
    }
    
    

    
    
    //override setValue forUndefineKey to prevent the App crash
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    //save the data
    func saveUserData() {
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last
        let filePath = path! + "/account.plist"
        NSKeyedArchiver.archiveRootObject(self, toFile: filePath)
        
    }
    
    //load user data
    class func loadUserData() -> CHSAccountInfo? {
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last
        let filePath = path! + "/account.plist"
        if let userAccount = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? CHSAccountInfo {
            
            if userAccount.expires_date?.compare(NSDate()) == .OrderedDescending{
                
                return userAccount
            }
            return nil
            
        }
        
        
        
        return nil
    }
    
//    encoding and decoding
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
//        expires_in = aDecoder.decodeObjectForKey("expires_in")
        expires_in = aDecoder.decodeDoubleForKey("expires_in")
        uid = aDecoder.decodeObjectForKey("uid") as? String
        name = aDecoder.decodeObjectForKey("name") as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
        expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
//        aCoder.encodeObject(expires_in, forKey: "expires_in")
        aCoder.encodeDouble(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
        aCoder.encodeObject(expires_date, forKey: "expires_date")
    }
    
    
}
