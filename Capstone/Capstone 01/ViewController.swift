//
//  ViewController.swift
//  Capstone 01
//
//  Created by Rick Bowen on 10/2/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player:AVPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url = NSURL.URLWithString("http://thejordanexperience.org/teachings/74/Examine_Yourself.mp3")
        self.player = AVPlayer.playerWithURL(url) as AVPlayer
        println("Player: init with URL")
        
        self.player.play()
        println("Player: playing...")

        
        
        /*
        let url = "http://thejordanexperience.org/teachings/74/Examine_Yourself.mp3"
        let playerItem = AVPlayerItem(URL:NSURL(string:url))
        self.player = AVPlayer(playerItem:playerItem)
        self.player.play()
        */
        
        //func playerWithURL(URL: NSURL!) -> AnyObject! {
        //}
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

