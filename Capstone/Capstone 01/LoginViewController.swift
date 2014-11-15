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
    @IBOutlet weak var spinnerOutlet: UIActivityIndicatorView!
    
    @IBAction func loginAction(sender: AnyObject)
    {
        // To do: add client side validation
        var validForm = validateLoginForm()
        
        if validForm
        {
            tryToLogin()
        }
        else
        {
            showValidationErrors()
        }
    }
    
    func validateLoginForm() -> Bool
    {
        var success = true
        if self.emailInputOutlet.text == "" || self.passwordInputOutlet.text == ""
        {
            success = false
        }
        
        return success
    }
    
    func showValidationErrors()
    {
        let alert = UIAlertView()
        alert.title = "Try again"
        alert.message = "Enter your email and password"
        alert.addButtonWithTitle("Okay")
        alert.show()
    }
    
    func tryToLogin()
    {
        self.spinnerOutlet.startAnimating()
        self.apiDataManager.login(self.emailInputOutlet.text, p:self.passwordInputOutlet.text)
    }
    
    func showLoginFailedMessage()
    {
        let alert = UIAlertView()
        alert.title = "Login Failed"
        alert.message = "Please try again"
        alert.addButtonWithTitle("Okay")
        alert.show()
    }
    
    // MARK: APIDataManagerLoginDelegate protocol methods
    
    func APILoginCallBack(senderClass: AnyObject, response: AnyObject)
    {
        self.spinnerOutlet.stopAnimating()
        if response !== false
        {
            self.jordanSession.setSessionToken(response as NSString)
            AppDelegate.getContainerViewController().enterApp()
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
