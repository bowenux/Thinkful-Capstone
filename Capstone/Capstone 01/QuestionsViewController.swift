//
//  QuestionsViewController.swift
//  Capstone 01
//
//  Created by Rick Bowen on 11/10/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit

class QuestionsViewController:
    UIViewController
{

    let transitionManager = GlobalMenuTransitionManager()
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var questionNavy: UINavigationItem!
    
    @IBAction func returnToViewController (sender: UIStoryboardSegue)
    {
        self.dismissViewControllerAnimated(true, completion: nil)// bug? exit segue doesn't dismiss so we do it manually...
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "ToGlobalMenu"
        {
            let menu = segue.destinationViewController as MenuViewController
            menu.transitioningDelegate = self.transitionManager
            self.transitionManager.menuViewController = menu
        }
        else
        {
            // Unknown segue identifier
        }
    }
}
