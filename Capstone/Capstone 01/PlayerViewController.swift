//
//  PlayerViewController.swift
//  Capstone 01
//
//  Created by Rick Bowen on 10/26/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit
import AVFoundation

protocol MiniPlayerDelegate
{
    func setupMiniPlayer(senderClass: AnyObject, audio: JordanAudioObject)
}

class PlayerViewController:
    UIViewController
{
    var player:AVPlayer?
    var audioPlayer = JordanAudioPlayer()
    var jordanAudioObject:JordanAudioObject?
    var delegate: MiniPlayerDelegate?
    
    func create()
    {
        view.frame = CGRectMake( 0, view.frame.size.height, view.frame.size.width, view.frame.size.height );
    }
    
    func playJordanAudioObject() -> ()
    {
        if let urlSrc = self.jordanAudioObject?.urlSrc
        {
            self.audioPlayer.open(urlSrc)
        }
        else
        {
            println("unable to play: I don't have a urlSrc in the JordanAudioObject, or a JordanAudioObject at all! Set the instance property first!")
        }
    }
    
    func playWithUrl(url:String?) -> ()
    {
        self.audioPlayer.open(url!)
    }
    
    func hide()
    {
        println("hidden")
        let verticalOffset = self.view.frame.size.height
        self.view.frame = CGRectMake( 0, verticalOffset, self.view.frame.size.width, self.view.frame.size.height );
    }
    func showMiniPlayer()
    {
        // prepare miniplayer
        if let setDelegate = self.delegate?
        {
            setDelegate.setupMiniPlayer(self, audio: jordanAudioObject!)
        }
        else
        {
            println("No delegate set for showMiniPlayer()")
        }
        
        
        // slide up this view controller
        let verticalOffset = self.view.frame.size.height - 50
        self.view.frame = CGRectMake( 0, verticalOffset, self.view.frame.size.width, self.view.frame.size.height );
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
