//
//  LoginTableViewController.swift
//  Capstone 01
//
//  Created by Rick Bowen on 11/26/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit

class LoginTableViewController: UITableViewController, UITextFieldDelegate, APIDataManagerLoginDelegate {
    
    let apiDataManager = APIDataManager()
    var jordanSession = AppDelegate.getJordanSession()
    
    
    
    @IBOutlet weak var emailInputOutlet: UITextField!
    @IBOutlet weak var passwordInputOutlet: UITextField!
    @IBOutlet weak var spinnerOutlet: UIActivityIndicatorView!
    
    @IBAction func loginAction(sender: AnyObject)
    {
        submitLoginForm()
    }
    
    func submitLoginForm()
    {
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
    
    // MARK: - UITextFieldDelegate protocol methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        println("textfield enter()")
        
        if textField.tag == 1 {
            // email field
            self.passwordInputOutlet.becomeFirstResponder()
        } else {
            // password field
            textField.resignFirstResponder()
            submitLoginForm()
        }
        
        return true
    }
    
    
    
    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.apiDataManager.loginDelegate = self
        self.emailInputOutlet.delegate = self
        self.passwordInputOutlet.delegate = self
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        self.emailInputOutlet.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - APIDataManagerLoginDelegate protocol methods
    
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

    
    // MARK: - Table view data source

   

}
