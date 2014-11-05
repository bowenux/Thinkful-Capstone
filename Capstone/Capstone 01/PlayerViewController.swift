//
//  PlayerViewController.swift
//  Capstone 01
//
//  Created by Rick Bowen on 10/26/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit

class PlayerViewController:
    UIViewController
{
    var jordanAudioManager = AppDelegate.audioManager()
    
    @IBOutlet weak var miniPlayerContainer: UIView!
    
    @IBAction func btnPlayPausee(sender: AnyObject)
    {
        self.jordanAudioManager.togglePlayPause()
    }
    
    @IBAction func btnClosePlayer(sender: AnyObject)
    {
        self.showMiniPlayer()
    }
    
    func create()
    {
        view.frame = CGRectMake( 0, view.frame.size.height, view.frame.size.width, view.frame.size.height );
    }
    
    func showMiniPlayer()
    {
        self.miniPlayerContainer.alpha = 1
        
        // slide up this view controller
        let verticalOffset = self.view.frame.size.height - 50
        self.view.frame = CGRectMake( 0, verticalOffset, self.view.frame.size.width, self.view.frame.size.height );
    }
    
    func show()
    {
        //hide miniPlayer
        self.miniPlayerContainer.alpha = 0
        // slide up this view controller
        self.view.frame = CGRectMake( 0, 0, self.view.frame.size.width, self.view.frame.size.height );
    }
    
    func hide()
    {
        println("hidden")
        let verticalOffset = self.view.frame.size.height
        self.view.frame = CGRectMake( 0, verticalOffset, self.view.frame.size.width, self.view.frame.size.height );
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
