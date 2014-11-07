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
    @IBOutlet weak var btnPlayPause: UIButton!
    @IBOutlet weak var audioTitleLabel: UILabel!
    @IBOutlet weak var audioAlbumArt: UIImageView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var audioProgressBar: UIProgressView!
    
    @IBAction func togglePlayPause(sender: AnyObject)
    {
        var playing = self.jordanAudioManager.togglePlayPause()
        if playing
        {
            self.btnPlayPause.setTitle("Pause", forState: .Normal)
        }
        else
        {
            self.btnPlayPause.setTitle("Play", forState: .Normal)
        }
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
    
    func preparePlayer()
    {
        if let currentJordanAudioObject = self.jordanAudioManager.currentJordanAudioObject
        {
            //set label
            self.audioTitleLabel.text = currentJordanAudioObject.name
            
            //set image
            let albumArtImageURL = NSURL(string: currentJordanAudioObject.albumArtLarge)
            if let imageData = NSData(contentsOfURL: albumArtImageURL!){
                self.audioAlbumArt.image = UIImage(data: imageData)
            }
            
        }
    }
    
    func updatePlayerTimes()
    {
        self.currentTimeLabel.text = self.jordanAudioManager.audioCurrentTime
        self.totalTimeLabel.text = self.jordanAudioManager.audioTotalTime
        self.audioProgressBar.setProgress(self.jordanAudioManager.audioPercentComplete, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // listener for playerLoadedNotification
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "preparePlayer",
            name: playerLoadedNotification.key,
            object: nil
        )
        
        // listener for playerLoadedNotification
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "updatePlayerTimes",
            name: playerTimeUpdatedNotification.key,
            object: nil
        )
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
