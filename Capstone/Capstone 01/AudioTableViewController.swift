//
//  AudioTableViewController.swift
//  Capstone 01
//
//  Created by Rick Bowen on 10/4/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit

class AudioTableViewController:
    UITableViewController,
    UIActionSheetDelegate,
    UISearchBarDelegate,
    UISearchDisplayDelegate,
    GetAudioCallBack
{
    let dataManager = APIDataManager()
    var allAudio:[JordanAudioObject] = []
    var filteredAudio:[JordanAudioObject] = []
    let transitionManager = TransitionManager()
    
    @IBAction func filterAudio(sender: AnyObject) {
        println("Sort was tapped")
        
        var sheet: UIActionSheet = UIActionSheet();
        let title: String = "Sort by";
        sheet.title  = title;
        sheet.delegate = self;
        sheet.addButtonWithTitle("Cancel");
        sheet.addButtonWithTitle("Most Recent");
        sheet.addButtonWithTitle("Title (A-Z)");
        sheet.addButtonWithTitle("Title (Z-A)");
        sheet.cancelButtonIndex = 0;
        sheet.showInView(self.view);
        
    }
   
    @IBAction func returnToViewController (sender: UIStoryboardSegue){
        // bug? exit segue doesn't dismiss so we do it manually...
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func actionSheet(sheet: UIActionSheet!, clickedButtonAtIndex buttonIndex: Int) {
        println("index %d %@", buttonIndex, sheet.buttonTitleAtIndex(buttonIndex));
        
        sortAudioTable(sheet.buttonTitleAtIndex(buttonIndex))
        
    }
    
    func sortAudioTable(column:String) -> ()
    {
        switch column
        {
            case "Most Recent":
                self.allAudio.sort{ $0.dateRecorded < $1.dateRecorded }
            
            case "Title (A-Z)":
                self.allAudio.sort{ $0.name < $1.name }
            
            case "Title (Z-A)":
                self.allAudio.sort{ $0.name > $1.name }
            
            default:
                println("Error: Unknown column to sort by...")
        }
        self.tableView.reloadData()
    }
    
    func filterContentForSearchText(searchText: String)
    {
        // Filter the array using the filter method
        self.filteredAudio = self.allAudio.filter(
        {
            (allAudio: JordanAudioObject) -> Bool in
            //let stringMatch = allAudio.name.rangeOfString(searchText)
            let stringMatch = allAudio.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return stringMatch != nil
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool
    {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool
    {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
        return true
    }
    
    func didApiRespond(senderClass: AnyObject, response: [JordanAudioObject])
    {
        println("AudioObject at didAPIRespond()")
        
        self.allAudio = response
        
        println("reloading table data...")
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // now we'll have a handy reference to this view controller
        // from within our transition manager object
        self.transitionManager.sourceViewController = self
        
        println("calling api...")
        
        self.dataManager.delegate = self
        var audioData: () = self.dataManager.getAllAudio()
        
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
       
        
        if tableView == self.searchDisplayController!.searchResultsTableView
        {
            return self.filteredAudio.count
        }
        else
        {
            return self.allAudio.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        
        //ask for a reusable cell from the tableview, the tableview will create a new one if it doesn't have any
        //let cell = self.tableView.dequeueReusableCellWithIdentifier("audioListing") as UITableViewCell
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("audioListing", forIndexPath: indexPath) as UITableViewCell
        
        var audio : JordanAudioObject
        // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
        if tableView == self.searchDisplayController!.searchResultsTableView {
            audio = self.filteredAudio[indexPath.row]
        } else {
            audio = self.allAudio[indexPath.row]
        }
        
        
        // Configure the cell
        cell.textLabel.text = audio.name
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator // what does this do?
        
        /*
        if !self.allAudio.isEmpty
        {
            cell.textLabel?.text = self.allAudio[indexPath.row].name
        }
        else
        {
            println("array of AudioObject is empty")
        }
        */
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
            let theSelectedRow = self.allAudio[indexPath!.row]
            let theDestination = (segue.destinationViewController as AudioViewController)
            
            theDestination.audioDetailName = theSelectedRow.name
            theDestination.audioDetailAlbumArt = theSelectedRow.albumArtLarge
            theDestination.audioDetailUrlSrc = theSelectedRow.urlSrc
            theDestination.audioDetailSpeaker = theSelectedRow.speaker
            theDestination.audioDetailDateRecorded = theSelectedRow.dateRecorded
            theDestination.audioDetailLocationRecorded = theSelectedRow.locationRecorded
            
        }
        else if segue.identifier == "ToGlobalMenu"
        {   
            let menu = segue.destinationViewController as MenuViewController
            menu.transitioningDelegate = self.transitionManager
            self.transitionManager.menuViewController = menu
        }
        else
        {
            // Unknown segue identifier
        }
    }


}
