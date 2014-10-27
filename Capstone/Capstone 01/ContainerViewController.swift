//
//  ContainerViewController.swift
//  Capstone 01
//
//  Created by Rick Bowen on 10/27/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var audioTableNavigationController: UINavigationController!
    var audioTableViewController: AudioTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioTableViewController = UIStoryboard.audioTableViewController()
        //audioTableViewController.delegate = self
        
        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        audioTableNavigationController = UINavigationController(rootViewController: audioTableViewController)
        view.addSubview(audioTableNavigationController.view)
        addChildViewController(audioTableNavigationController)
        
        audioTableNavigationController.didMoveToParentViewController(self)
        
        
        
        // now try to add the player in a hidden state
        
        var playerViewController: PlayerViewController
        
        var delegate = UIApplication.sharedApplication().delegate as AppDelegate
        playerViewController = UIStoryboard.playerViewController()!
        
        delegate.playerViewController = playerViewController
        
        var playerView = playerViewController.view
        let verticalOffset = playerView.frame.size.height// - 50
        playerView.frame = CGRectMake( 0, verticalOffset, playerView.frame.size.width, playerView.frame.size.height );
     
        view.insertSubview(playerViewController.view, atIndex: 2)
        
        addChildViewController(playerViewController)
        //playerViewController.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
    class func playerViewController() -> PlayerViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("PlayerViewController") as? PlayerViewController
    }
    
    class func audioTableViewController() -> AudioTableViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("AudioTableViewController") as? AudioTableViewController
    }
}
