//
//  MiniPlayerViewController.swift
//  Capstone 01
//
//  Created by Rick Bowen on 11/2/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit

class MiniPlayerViewController:
    UIViewController
{
    var audioManager = AppDelegate.audioManager()
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // listener for playerNotification
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "prepareMiniPlayer",
            name: AppDelegate.notificationKey(),
            object: nil
        )
    }
   
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    

    func prepareMiniPlayer() {
        if let currentJordanAudioObject = self.audioManager.currentJordanAudioObject
        {
            nameLabel.text = currentJordanAudioObject.name
        }
    }

}
