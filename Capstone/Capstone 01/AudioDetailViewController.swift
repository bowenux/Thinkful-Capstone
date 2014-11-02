//
//  AudioViewController.swift
//  Capstone 01
//
//  Created by Rick Bowen on 10/2/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit
import AVFoundation

class AudioDetailViewController:
    UIViewController
{
    var player:AVPlayer?
    var audioObject:JordanAudioObject?
    
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
    
    @IBAction func playBtnTouch(sender: AnyObject)
    {
        
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var playerViewController = appDelegate.playerViewController // get PlayerViewController
        //println(self.audioObject?.urlSrc)
        playerViewController?.playWithUrl(self.audioObject?.urlSrc)
        playerViewController?.showMiniPlayer()
        
    }
    
    // part of view life cycle
    override func viewWillDisappear(animated: Bool) {
        
        var delegate = UIApplication.sharedApplication().delegate as AppDelegate
        var e = delegate.playerViewController
        //e?.hide()
        
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //set labels
        self.nameLabel.text = self.audioObject?.name
        self.navigationTitle.title = self.audioObject?.name
        self.speakerLabel.text = self.audioObject?.speaker
        self.dateRecordedLabel.text = self.audioObject?.dateRecorded
        self.locationRecordedLabel.text = self.audioObject?.locationRecorded
        /*
        //set image
        let albumArtImageURL = NSURL(string: self.audioObject?.albumArtLarge)
        let imageData = NSData(contentsOfURL: albumArtImageURL!)
        self.albumArtImage.image = UIImage(data: imageData!)
*/
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
