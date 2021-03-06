//
//  AudioTableViewController.swift
//  Capstone 01
//
//  Created by Rick Bowen on 10/4/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit

class AudioTableViewController: UITableViewController {
    
    struct audioInfo {
        var name: String
        var thumbnail: String
        var urlSrc: String
    }
    var audios: [audioInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("calling api...")
        
        let manager = AFHTTPRequestOperationManager()
        manager.GET( "http://api.bowenux.com/v1/audio",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                print("looping over api data...")
                
                //println("JSON: " + responseObject.description)
                
                if let dataArray = responseObject.valueForKey("data") as? [AnyObject] {
                    for var i = 0; i < dataArray.count; i++ {
                        let dataObject: AnyObject = dataArray[i]
                        let audioName = dataObject.valueForKeyPath("name") as? String
                        let audioThumb = dataObject.valueForKeyPath("albumArtSmall") as? String
                        let audioSrc = dataObject.valueForKeyPath("audioUrl") as? String
                        
                        var nextAudio = audioInfo(name: audioName!, thumbnail: audioThumb!, urlSrc: audioSrc!)
                        self.audios.append(nextAudio)
                    }
                }
                println(" done")
                self.tableView.reloadData()
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return audios.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
  //override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("audioListing", forIndexPath: indexPath) as UITableViewCell

        cell.textLabel?.text = audios[indexPath.row].name

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ToAudioDetail"
        {
            let indexPath = self.tableView.indexPathForSelectedRow()
            let theSelectedRow = audios[indexPath!.row]
            let theDestination = (segue.destinationViewController as ViewController)
            
            theDestination.audioDetailName = theSelectedRow.name
            theDestination.audioDetailUrlSrc = theSelectedRow.urlSrc
            
        }
    }
    

}
