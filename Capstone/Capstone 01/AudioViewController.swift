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
    
    @IBAction func playBtnTouch(sender: AnyObject) {
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        self.playURL()
        
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

