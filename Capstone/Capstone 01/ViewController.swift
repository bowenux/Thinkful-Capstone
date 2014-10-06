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
    
    var player:AVPlayer?
    var audioDetailName:String?
    var audioDetailUrlSrc:String?
    
    
    func playURL() {
        
        var url = NSURL.URLWithString(self.audioDetailUrlSrc!)
        self.player = AVPlayer.playerWithURL(url) as? AVPlayer
        println("player: with URL \(self.audioDetailUrlSrc)")
        self.player?.play()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        self.playURL()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // ======== respond to remote controls
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
    }
    
    override func remoteControlReceivedWithEvent(event: UIEvent) {
        let rc = event.subtype
        println("received remote control ")
        
        if let p = self.player {
            switch rc {
            case .RemoteControlTogglePlayPause:
                if p.externalPlaybackActive { p.pause() } else { p.play() }
            case .RemoteControlPlay:
                p.play()
            case .RemoteControlPause:
                p.pause()
            default:break
            }
        } else {
            //player not initiated
        }
    }
    
    
}

