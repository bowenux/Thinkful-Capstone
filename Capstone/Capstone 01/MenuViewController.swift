//
//  MenuViewController.swift
//  Capstone 01
//
//  Created by Rick Bowen on 10/23/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit

class MenuViewController:
    UIViewController
    ,UITableViewDelegate
    ,UITableViewDataSource
{
    var jordanSession = AppDelegate.getJordanSession()
    var items: [String] = ["Browse", "Questions", "Settings"]
    var containerViewController = AppDelegate.getContainerViewController()
    
    @IBOutlet weak var menuTitle: UILabel!
    @IBOutlet weak var menuSubTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func logoutAction(sender: AnyObject)
    {
       self.jordanSession.logout()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Customize apperance of table view
        self.tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0)
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.scrollsToTop = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // MARK: - Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        cell.textLabel.text = self.items[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("menu tapped")
        self.containerViewController.showQuestions()
    }
    
}
