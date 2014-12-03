//
//  JordanAudioManager.swift
//  Capstone 01
//
//  Created by Rick Bowen on 11/3/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer

class JordanAudioManager
{
    var player: AVPlayer?
    var currentJordanAudioObject: JordanAudioObject?
    var isPlaying: Bool = false
    var isPlayerEmpty: Bool = true
    var isPlayerItemInit: Bool = false
    var audioCurrentTime: String = ""
    var audioTotalTime: String = ""
    var audioTotalTimeInSeconds: Float64 = 0
    var audioPercentComplete: Float = 0
    let infoCenter = MPNowPlayingInfoCenter.defaultCenter()
    
    init(){}
    
    func mediaPicker(mediaPicker: MPMediaPickerController!,
        didPickMediaItems mediaItemCollection: MPMediaItemCollection!)
    {
        println("Media Picker returned")
    }
    
    func prepare(audioObject: JordanAudioObject) -> ()
    {
        var url = NSURL(string: audioObject.urlSrc)
        self.player = AVPlayer.playerWithURL(url) as? AVPlayer
        self.currentJordanAudioObject = audioObject
        self.isPlayerEmpty = false
        
        // add observer to handle audio progression
        self.player?.addPeriodicTimeObserverForInterval(CMTimeMakeWithSeconds(1, 1), queue: nil) {
            (CMTime) -> Void in
            self.updateAudioTimes()
        }
        
        // allow all to recieve remote control events (i.e., control center)
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        
        
        // send notification that player has been loaded
        NSNotificationCenter.defaultCenter().postNotificationName(playerLoadedNotification.key, object: self)
    }
    
    func updateAudioTimes()
    {
        if !self.isPlayerItemInit
        {
            updateInfoCenterWithPlayerItem(self.isPlaying)
        }
        
        if let playerItem = self.player?.currentItem
        {
            // update time labels
            self.audioTotalTimeInSeconds = CMTimeGetSeconds(playerItem.duration)
            
            // audioTotalTimeInSeconds can be nan while file is downloading
            if !self.audioTotalTimeInSeconds.isNaN
            {
                self.audioTotalTime = convertSecondsToHMMSS(self.audioTotalTimeInSeconds)
                self.audioCurrentTime = convertSecondsToHMMSS( CMTimeGetSeconds(playerItem.currentTime()) )
                self.audioPercentComplete = calcPercentComplete(CMTimeGetSeconds(playerItem.currentTime()), complete: CMTimeGetSeconds(playerItem.duration))

            }
            // send notification that player has been updated
            NSNotificationCenter.defaultCenter().postNotificationName(playerTimeUpdatedNotification.key, object: self)
        }
    }
    
    func updateInfoCenterWithPlayerItem(playing: Bool)
    {
        if let hasPlayerItem = self.player?.currentItem
        {
            if let hasJordanAudioObject = self.currentJordanAudioObject
            {
                let playback = (playing) ? "1.0" : "0.0"
                
                self.infoCenter.nowPlayingInfo = [
                    MPMediaItemPropertyTitle:hasJordanAudioObject.name,
                    MPMediaItemPropertyArtist:hasJordanAudioObject.speaker,
                    MPMediaItemPropertyPlaybackDuration:CMTimeGetSeconds(hasPlayerItem.duration),
                    MPNowPlayingInfoPropertyPlaybackRate: playback,
                    MPNowPlayingInfoPropertyElapsedPlaybackTime: CMTimeGetSeconds(hasPlayerItem.currentTime()),
                    //MPMediaItemPropertyArtwork:hasJordanAudioObject.albumArtLarge
                ]
            }
            self.isPlayerItemInit = true
        }
    }
    
    func convertSecondsToHMMSS(CMTimeInSeconds: Double) -> String
    {
        let audioLengthHrs = Int(floor(CMTimeInSeconds / 3600))
        let audioLengthMins = Int(floor(Float((Int(CMTimeInSeconds) - (audioLengthHrs*3600)) / 60)))
        let audioLengthSecs = Int(floor(CMTimeInSeconds % 60))
        
        var audioLengthHrsString = String(audioLengthHrs)
        var audioLengthMinsString = String(audioLengthMins)
        var audioLengthSecsString = String(audioLengthSecs)
        if audioLengthMins <= 9 && audioLengthHrs > 0
        {
            audioLengthMinsString = "0" + audioLengthMinsString // prepend with 0 for "mm" format if h:mm:ss
        }
        if audioLengthSecs <= 9
        {
            audioLengthSecsString = "0" + audioLengthSecsString // prepend with 0 for "ss" format
        }
        
        let timeString = (audioLengthHrs == 0) ? "\(audioLengthMinsString):\(audioLengthSecsString)" : "\(audioLengthHrsString):\(audioLengthMinsString):\(audioLengthSecsString)"
        return timeString
    }
    
    func convertPercentToHMMSS(value:Float) -> String
    {
        let timeInSeconds = convertPercentToTime(value)
        let timeFormatted = convertSecondsToHMMSS(Double(timeInSeconds.value))
        return timeFormatted
    }
    
    func convertPercentToTime(value:Float) -> CMTime
    {
        let newTimeInSeconds = value * Float(self.audioTotalTimeInSeconds)
        let newTime = CMTimeMakeWithSeconds(Float64(newTimeInSeconds), 1)
        return newTime
    }
    
    func calcPercentComplete(current: Double, complete: Double) -> Float
    {
        let amountCompleted = current/complete
        let numberOfPlaces = 2.0 // number of places to round
        let multiplier = pow(10.0, numberOfPlaces)
        let amountCompletedRounded = round(amountCompleted * multiplier) / multiplier
       
        return Float(amountCompletedRounded)
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
            
            if self.isPlayerItemInit
            {
                updateInfoCenterWithPlayerItem(self.isPlaying)
            }
            
            // send notification that player has been played/paused
            NSNotificationCenter.defaultCenter().postNotificationName(playerPlaybackUpdatedNotification.key, object: self)
            
            println("playing...")
            
        }
    }
    
    func pause() -> ()
    {
        self.player?.pause()
        self.isPlaying = false
        
        if self.isPlayerItemInit
        {
            updateInfoCenterWithPlayerItem(self.isPlaying)
        }
        
        // send notification that player has been played/paused
        NSNotificationCenter.defaultCenter().postNotificationName(playerPlaybackUpdatedNotification.key, object: self)
        
        println("paused.")
    }
    
    func seekTo(value:Float) -> ()
    {
       let newTime = convertPercentToTime(value)
       self.player?.seekToTime(newTime)
    }
}