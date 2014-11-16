//
//  AudioViewController.swift
//  Capstone 01
//
//  Created by Rick Bowen on 10/2/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit

class AudioDetailViewController:
    UIViewController
{
    var jordanAudioObject:JordanAudioObject?
    var jordanAudioManager = AppDelegate.audioManager()
    
    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speakerLabel: UILabel!
    @IBOutlet weak var dateRecordedLabel: UILabel!
    @IBOutlet weak var locationRecordedLabel: UILabel!
    @IBOutlet weak var albumArtImage: UIImageView!
    @IBOutlet weak var playBtn: UIButton!
    
    @IBAction func playBtnTouch(sender: AnyObject)
    {
        var playerViewController = AppDelegate.getPlayerViewController() // get PlayerViewController
        
        self.jordanAudioManager.prepare(jordanAudioObject!)
        self.jordanAudioManager.play()
        playerViewController.showMiniPlayer()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //set labels
        self.nameLabel.text = self.jordanAudioObject?.name
        self.navigationTitle.title = self.jordanAudioObject?.name
        self.speakerLabel.text = self.jordanAudioObject?.speaker
        self.dateRecordedLabel.text = self.jordanAudioObject?.dateRecorded
        self.locationRecordedLabel.text = self.jordanAudioObject?.locationRecorded
        
        //set image
        if let theAlbumArt = self.jordanAudioObject?.albumArtLarge
        {
            let albumArtImageURL = NSURL(string: theAlbumArt)
            let imageData = NSData(contentsOfURL: albumArtImageURL!)
            self.albumArtImage.image = UIImage(data: imageData!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
