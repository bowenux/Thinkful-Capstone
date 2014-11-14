//
//  ContainerViewController.swift
//  Capstone 01
//
//  Created by Rick Bowen on 10/27/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit

//  This class will serve as a "wrapper" ViewController, 
//  allowing us to show multiple views at the same time (e.g., the playerViewController)
class ContainerViewController: UIViewController {
    
    var userLoggedIn = false
    var audioTableNavigationController: UINavigationController!
    var audioTableViewController: AudioTableViewController!
    var loginViewController: LoginViewController!
    var questionViewController: UIViewController!
    let transitionManager = GlobalMenuTransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.redColor()
        
        if self.userLoggedIn
        {
            showAudioInTable() // load table that will make API call
            initPlayerViewController() // create a player in a hidden state
        }
        else
        {
            showLoginView()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func removeAllViewsInContainer()
    {
        for view in self.view.subviews
        {
            if view.tag != 100 {
                view.removeFromSuperview()
            }
        }
    }
    
    func showQuestions()
    {
     removeAllViewsInContainer()
        // grab the AudioTableViewController
        self.questionViewController = UIStoryboard.questionsViewController()
        
        // wrap the audioTableViewController in a navigation controller,
        // so we can push views to it and display bar button items in the navigation bar
        self.audioTableNavigationController = UINavigationController(rootViewController: questionViewController)
        
        // add audioTableViewController to the view
        view.addSubview(self.audioTableNavigationController.view)
        addChildViewController(self.audioTableNavigationController)
        
        // i'm not exactly sure what this does...
        self.audioTableNavigationController.didMoveToParentViewController(self)
        
        
        //self.transitionManager.menuViewController.performSegueWithIdentifier("CloseGlobalMenu", sender: self)
    }
    
    func showAudioInTable()
    {
        // grab the AudioTableViewController
        self.audioTableViewController = UIStoryboard.audioTableViewController()
        
        // wrap the audioTableViewController in a navigation controller,
        // so we can push views to it and display bar button items in the navigation bar
        self.audioTableNavigationController = UINavigationController(rootViewController: audioTableViewController)
        
        // add audioTableViewController to the view
        view.addSubview(self.audioTableNavigationController.view)
        addChildViewController(self.audioTableNavigationController)
        
        // i'm not exactly sure what this does...
        self.audioTableNavigationController.didMoveToParentViewController(self)
    }
    
    func initPlayerViewController()
    {
        var playerViewController: PlayerViewController
        var delegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        playerViewController = UIStoryboard.playerViewController()! // get PlayerViewController from storyboard
        delegate.playerViewController = playerViewController // update the playerViewController in the AppDelegate
        
        playerViewController.create() // put player in hidden container
        playerViewController.view.tag = 100
        
        view.insertSubview(playerViewController.view, atIndex: 2) // add player to ContainerViewController (still hidden)
        
        // I dont know what these do... seems to work if commented out
        addChildViewController(playerViewController)
        playerViewController.didMoveToParentViewController(self)
    }
    
    func showLoginView()
    {
        
        self.loginViewController = UIStoryboard.loginViewController()
        
        
        self.audioTableNavigationController = UINavigationController(rootViewController: loginViewController)
        
        // add audioTableViewController to the view
        view.addSubview(self.audioTableNavigationController.view)
        addChildViewController(self.audioTableNavigationController)
        
        // i'm not exactly sure what this does...
        self.audioTableNavigationController.didMoveToParentViewController(self)
    }
}

// Helper functions for grabbing ViewControllers from the storyboard(s)
private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
    class func loginViewController() -> LoginViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("LoginViewController") as? LoginViewController
    }
    
    class func playerViewController() -> PlayerViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("PlayerViewController") as? PlayerViewController
    }
    
    class func audioTableViewController() -> AudioTableViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("AudioTableViewController") as? AudioTableViewController
    }
    
    class func questionsViewController() -> UIViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("QuestionsViewController") as? UIViewController
    }
}
