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
    @IBOutlet weak var albumArtThumb: UIImageView!
    
    @IBAction func showFullPlayerBtn(sender: AnyObject)
    {
        var playerViewController = AppDelegate.getPlayerViewController()
        playerViewController.show()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // listener for playerNotification
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "prepareMiniPlayer",
            name: playerLoadedNotification.key,
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
            //set label
            nameLabel.text = currentJordanAudioObject.name
            
            //set image
            let albumArtImageURL = NSURL(string: currentJordanAudioObject.albumArtThumb)
            let imageData = NSData(contentsOfURL: albumArtImageURL!)
            self.albumArtThumb.image = UIImage(data: imageData!)
            
        }
    }

}
