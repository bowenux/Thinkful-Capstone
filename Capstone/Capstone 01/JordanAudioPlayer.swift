//
//  JordanAudioPlayer.swift
//  Capstone 01
//
//  Created by Rick Bowen on 10/28/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit
import AVFoundation

class JordanAudioPlayer
{
    var player:AVPlayer?
    
    init(){}
    
    func open(file:String) -> ()
    {
        println("open with file: \(file)")
        var url = NSURL(fileURLWithPath: file)
        self.player = AVPlayer.playerWithURL(url) as? AVPlayer
        self.play()
    }
    func play()
    {
        println("play!")
        self.player?.play()
    }
}