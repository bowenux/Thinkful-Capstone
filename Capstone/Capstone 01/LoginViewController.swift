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
    
    @IBOutlet weak var emailInputOutlet: UITextField!
    @IBOutlet weak var passwordInputOutlet: UITextField!
    
    @IBAction func loginAction(sender: AnyObject)
    {
        tryToLogin()
    }
    
    func tryToLogin()
    {
        self.apiDataManager.login(self.emailInputOutlet.text, p:self.passwordInputOutlet.text)
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
            // how can I programatically create/invoke a segue to AudioTableViewController
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
