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
    var isPlayerEmpty: Bool = true
    
    init(){}
    
    func prepare(audioObject: JordanAudioObject) -> ()
    {
        var url = NSURL(string: audioObject.urlSrc)
        self.player = AVPlayer.playerWithURL(url) as? AVPlayer
        self.currentJordanAudioObject = audioObject
        self.isPlayerEmpty = false
        
        // allow all to recieve remote control events (i.e., control center)
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        
        //send notification
        NSNotificationCenter.defaultCenter().postNotificationName(playerLoadedNotification.key, object: self)
    }
    func updateNotificationSentLabel() {
       println("Notification sent!")
    }
    
    func togglePlayPause() -> Bool
    {
        if self.isPlaying
        {
            self.pause()
            return false
        }
        else
        {
            self.play()
            return true
        }
    }
    
    func play() -> ()
    {
        if let hasAudioObject = currentJordanAudioObject
        {
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