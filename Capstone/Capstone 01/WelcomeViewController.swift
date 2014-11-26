//
//  WelcomeViewController.swift
//  Capstone 01
//
//  Created by Rick Bowen on 11/16/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit

class WelcomeViewController:
    UIViewController
{
    
    let brandedBlue = UIColor(red: 0.22, green: 0.47, blue: 0.94, alpha: 1.0)
    
    @IBOutlet weak var loginBtnOutlet: UIButton!
    
    @IBAction func loginBtnActionTouchDown(sender: AnyObject) {
        self.loginBtnOutlet.backgroundColor = self.brandedBlue
    }
    @IBAction func loginBtnActionTouchUpInside(sender: AnyObject) {
        self.loginBtnOutlet.backgroundColor = UIColor.clearColor()
    }
    // MARK: - View lifecycle methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.loginBtnOutlet.backgroundColor = UIColor.clearColor()
        self.loginBtnOutlet.layer.borderWidth = 2
        self.loginBtnOutlet.layer.cornerRadius = self.loginBtnOutlet.frame.height / 2
        self.loginBtnOutlet.setTitleColor(self.brandedBlue, forState: .Normal)
        self.loginBtnOutlet.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        self.loginBtnOutlet.layer.borderColor = self.brandedBlue.CGColor
        
        
       // navigationController?.hidesBarsOnTap = true
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
