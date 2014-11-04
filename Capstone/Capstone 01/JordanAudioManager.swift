//
//  JordanAudioManager.swift
//  Capstone 01
//
//  Created by Rick Bowen on 11/3/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import Foundation
import AVFoundation

class JordanAudioManager
{
    var player: AVPlayer?
    var currentAudioObject:JordanAudioObject?
    var isPlaying:Bool = false
    
    init(){}
    
    func prepare(audioObject: JordanAudioObject) -> ()
    {
        self.currentAudioObject = audioObject
    }
    
    func play() -> ()
    {
        if let hasAudioObject = currentAudioObject
        {
            var url = NSURL(string: hasAudioObject.urlSrc)
            self.player = AVPlayer.playerWithURL(url) as? AVPlayer
            UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
            self.player?.play()
            self.isPlaying = true
            
            println("playing...")
        }
    }
    
    func pause() -> ()
    {
        self.player?.pause()
        self.isPlaying = false
        
        println("paused.")
    }
}