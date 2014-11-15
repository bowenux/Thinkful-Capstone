//
//  JordanSession.swift
//  Capstone 01
//
//  Created by Rick Bowen on 11/12/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import Foundation

class JordanSession
{
    let apiDataManager = APIDataManager()
    let sessionTokenKey: String = "com.bowenux.session.token"
    var userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var sessionToken: String?
    
    init()
    {
        self.sessionToken = userDefaults.objectForKey(self.sessionTokenKey) as? String
    }
    
    func setSessionToken(token:String)
    {
        self.sessionToken = token
        self.userDefaults.setObject(token, forKey: self.sessionTokenKey)
        self.userDefaults.synchronize()
    }
    
    func loggedIn() -> Bool
    {
        if let tokenExists = self.sessionToken
        {
            println("logged in? YES, my token is: \(self.sessionToken)")
            return true
        }
        else
        {
            println("logged in? NOPE, my token is: \(self.sessionToken)")
            return false
        }
    }
    
    func logout()
    {
        self.sessionToken = nil
        self.userDefaults.removeObjectForKey(self.sessionTokenKey)
        self.userDefaults.synchronize()
    }
    
    
    
}