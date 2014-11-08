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
    var jordanAudioManager = AppDelegate.audioManager()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var albumArtThumb: UIImageView!
    @IBOutlet weak var playPauseBtn: UIButton!
    
    @IBAction func showFullPlayerBtn(sender: AnyObject)
    {
        var playerViewController = AppDelegate.getPlayerViewController()
        playerViewController.show()
    }
    @IBAction func playPauseToggle(sender: AnyObject) {
        var playing = self.jordanAudioManager.togglePlayPause()
        if playing
        {
            self.playPauseBtn.setTitle("Pause", forState: .Normal)
        }
        else
        {
            self.playPauseBtn.setTitle("Play", forState: .Normal)
        }
    }
    
    func prepareMiniPlayer() {
        if let currentJordanAudioObject = self.jordanAudioManager.currentJordanAudioObject
        {
            //set label
            nameLabel.text = currentJordanAudioObject.name
            
            //set image
            let albumArtImageURL = NSURL(string: currentJordanAudioObject.albumArtThumb)
            let imageData = NSData(contentsOfURL: albumArtImageURL!)
            self.albumArtThumb.image = UIImage(data: imageData!)
            
        }
    }
    
    func updatePlayback()
    {
        if self.jordanAudioManager.isPlaying
        {
            self.playPauseBtn.setTitle("Pause", forState: .Normal)
        }
        else
        {
            self.playPauseBtn.setTitle("Play", forState: .Normal)
        }
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
        
        // listener for playerPlaybackUpdatedNotification
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "updatePlayback",
            name: playerPlaybackUpdatedNotification.key,
            object: nil
        )
    }
   
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
}
