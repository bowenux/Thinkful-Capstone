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
    var currentJordanAudioObject: JordanAudioObject?
    var isPlaying: Bool = false
    
    init(){}
    
    func prepare(audioObject: JordanAudioObject) -> ()
    {
        self.currentJordanAudioObject = audioObject
        //send notification
        NSNotificationCenter.defaultCenter().postNotificationName(playerLoadedNotification.key, object: self)
    }
    func updateNotificationSentLabel() {
       println("Notification sent!")
    }
    func play() -> ()
    {
        if let hasAudioObject = currentJordanAudioObject
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