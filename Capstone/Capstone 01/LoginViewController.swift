//
//  LoginViewController.swift
//  Capstone 01
//
//  Created by Rick Bowen on 11/12/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit

class LoginViewController:
    UIViewController
    ,APIDataManagerLoginDelegate
{
    let apiDataManager = APIDataManager()
    var jordanSession = AppDelegate.getJordanSession()
    
    @IBAction func loginAction(sender: AnyObject)
    {
        tryToLogin()
    }
    
    func tryToLogin()
    {
        self.apiDataManager.login("myUsername", p:"myPassword")
    }
    
    func showLoginFailedMessage()
    {
        println("Login failed.. Please try again!")
    }
    
    // MARK: APIDataManagerLoginDelegate protocol methods
    
    func APILoginCallBack(senderClass: AnyObject, response: AnyObject)
    {
        if response !== false
        {
            self.jordanSession.setSessionToken(response as NSString)
        }
        else
        {
            showLoginFailedMessage()
        }
        
        //testing
        println("after trying to login, my jordanSession token is: \(jordanSession.sessionToken)")
    }
    
    // MARK: View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.apiDataManager.loginDelegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
