//
//  ViewController.swift
//  Capstone 01
//
//  Created by Rick Bowen on 10/2/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController {
    
    var player:AVPlayer?
    var audioDetailName:String?
    var audioDetailUrlSrc:String?
    var audioDetailSpeaker:String?
    var audioDetailDateRecorded:String?
    var audioDetailLocationRecorded:String?
    var audioDetailAlbumArt:String?
    
    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speakerLabel: UILabel!
    @IBOutlet weak var dateRecordedLabel: UILabel!
    @IBOutlet weak var locationRecordedLabel: UILabel!
    @IBOutlet weak var albumArtImage: UIImageView!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var container: UIView!
    
    @IBAction func playBtnTouch(sender: AnyObject)
    {
        //Animate Container
        
        // lets set the duration to 1.0 seconds
        // and in the animations block change the background color
        // to red and the x-position  of the frame
        UIView.animateWithDuration(0.25, animations: {
            
            // for the x-position I entered 320-50 (width of screen - width of the square)
            // if you want, you could just enter 270
            // but I prefer to enter the math as a reminder of what's happenings
            self.container.frame = CGRect(x: 0, y: 667-50, width: 600, height: 50)
        })
        
        
        
        // Play audio
        //UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        //self.playURL()
        
    }
    
    func playURL()
    {
        var url = NSURL.URLWithString(self.audioDetailUrlSrc!)
        self.player = AVPlayer.playerWithURL(url) as? AVPlayer
        println("player: with URL \(self.audioDetailUrlSrc)")
        self.player?.play()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //set labels
        self.nameLabel.text = self.audioDetailName
        self.navigationTitle.title = self.audioDetailName
        self.speakerLabel.text = self.audioDetailSpeaker
        self.dateRecordedLabel.text = self.audioDetailDateRecorded
        self.locationRecordedLabel.text = self.audioDetailLocationRecorded
        
        //set image
        let albumArtImageURL = NSURL(string: self.audioDetailAlbumArt!)
        let imageData = NSData(contentsOfURL: albumArtImageURL)
        self.albumArtImage.image = UIImage(data: imageData)
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

