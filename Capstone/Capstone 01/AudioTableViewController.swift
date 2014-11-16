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
    APIDataManagerAudioDelegate
{
    let transitionManager = GlobalMenuTransitionManager()
    let apiDataManager = APIDataManager()
    let sortableAudio = SortAudioObject()
    var jordanSession = AppDelegate.getJordanSession()
    var allAudio:[JordanAudioObject] = []
    var filteredAudio:[JordanAudioObject] = []
    var initialDisplay = true
    
    @IBAction func filterAudio(sender: AnyObject)
    {
        createSortActionSheet()
    }
   
    @IBAction func returnToViewController (sender: UIStoryboardSegue)
    {
        self.dismissViewControllerAnimated(true, completion: nil)// bug? exit segue doesn't dismiss so we do it manually...
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // reference to this VC from GlobalMenuTransitionManager
        self.transitionManager.sourceViewController = self
        
        // call API
        self.apiDataManager.audioDelegate = self
        self.apiDataManager.getAllAudio(self.jordanSession.sessionToken!)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.initialDisplay
        {
            // hide search bar by default (swipe down to see)
            self.tableView.contentOffset = CGPointMake(0, -20)
            self.initialDisplay = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Sorting actionSheet methods
    func createSortActionSheet()
    {
        var sheet: UIActionSheet = UIActionSheet();
        sheet.delegate = self;
        sheet.title  = self.sortableAudio.title;
        for option in sortableAudio.sortingOptions
        {
            sheet.addButtonWithTitle(option.name)
        }
        sheet.addButtonWithTitle("Cancel");
        sheet.cancelButtonIndex = sortableAudio.sortingOptions.count;
        sheet.showInView(self.view);
    }
    
    func actionSheet(sheet: UIActionSheet!, clickedButtonAtIndex buttonIndex: Int)
    {
        if buttonIndex < self.sortableAudio.sortingOptions.count
        {
            self.allAudio = sortableAudio.sort(self.allAudio, index:sheet.buttonTitleAtIndex(buttonIndex))
            self.tableView.reloadData()
        }
    }
    
    // MARK: - API Manager protocol methods
    func APIGetAllDataCallBack(senderClass: AnyObject, success: Bool, response: [JordanAudioObject])
    {
        println("AudioObject at APIGetAllDataCallBack(): \(response.count) audios to show")
        if success
        {
            self.allAudio = response
            self.tableView.reloadData()
        }
        else
        {
            println("API returned error")
        }
    }
    
    // MARK: - Search protocol methods
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
    

    // MARK: - Table view protocol methods
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1// Return the number of sections.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == self.searchDisplayController!.searchResultsTableView
        {
            return self.filteredAudio.count
        }
        else
        {
            return self.allAudio.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("audioListing", forIndexPath: indexPath) as UITableViewCell
        var audio : JordanAudioObject
        // Check to see whether the normal table or search results table is being displayed
        if tableView == self.searchDisplayController!.searchResultsTableView {
            audio = self.filteredAudio[indexPath.row]
        } else {
            audio = self.allAudio[indexPath.row]
        }
        
        // Configure the cell
        cell.textLabel.text = audio.name
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator // what does this do?

        return cell
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "ToAudioDetail"
        {
            let indexPath = self.tableView.indexPathForSelectedRow()
            let audioDetailViewController = (segue.destinationViewController as AudioDetailViewController)
            audioDetailViewController.jordanAudioObject = self.allAudio[indexPath!.row]
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
