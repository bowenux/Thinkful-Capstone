//
//  MiniPlayerViewController.swift
//  Capstone 01
//
//  Created by Rick Bowen on 11/2/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit

class MiniPlayerViewController:
    UIViewController
    ,MiniPlayerDelegate
{
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupMiniPlayer(senderClass: AnyObject, audio: JordanAudioObject)
    {
        println("at setupMiniPlayer()")
        self.nameLabel.text = audio.name
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
