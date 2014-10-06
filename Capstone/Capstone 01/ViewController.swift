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
    
    var player: AVPlayer!
    
    var audioDetailName = ""
    var audioDetailUrlSrc = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url = NSURL.URLWithString(self.audioDetailUrlSrc)
        self.player = AVPlayer.playerWithURL(url) as AVPlayer
        println("player: with URL \(self.audioDetailUrlSrc)")
        
        self.player.play()
        println("player: play()")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

