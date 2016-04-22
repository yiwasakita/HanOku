//
//  ViewController.swift
//  HanOku
//
//  Created by tlsmooth89 on 4/21/16.
//  Copyright © 2016 yusuke.iwasaki. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Realm migration and acquireing a Realm instance.
    let realm: Realm = {
        var config = Realm.Configuration(schemaVersion: 1)
        Realm.Configuration.defaultConfiguration = config
        return try! Realm()
    } ()
    
    // A list to store items from the DB
    var itemArray = try! Realm().objects(Item).sorted("id", ascending: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDataSource protocol methods
    // Method to return the number of data/cells
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // Method to return each cell's content
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Getting reusable cells
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        // Setting values to the Cells
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        return cell
    }
    
    // MARK: UITableViewDelegate protocol methods
    // Method to be executed when a cell is selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("cellSegue", sender: nil)
    }
    
    // Method to tell that the cell is deletable
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    // Method to be called when the Delete button is pressed
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            // Cancelling the local notifications
            let item = itemArray[indexPath.row]
            
            // Cancelling if the same item has been already registered
            for notification in UIApplication.sharedApplication().scheduledLocalNotifications! {
                if notification.userInfo!["id"] as! Int == item.id {
                    UIApplication.sharedApplication().cancelLocalNotification(notification)
                    break
                }
            }
            
            // Deleting from the DB
            try! realm.write {
                self.realm.delete(self.itemArray[indexPath.row])
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }
        }
    }
 
 
    // segue method
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let inputViewController:InputViewController = segue.destinationViewController as! InputViewController
        
        if segue.identifier == "cellSegue" {
            let indexPath = self.tableView.indexPathForSelectedRow
            inputViewController.item = itemArray[indexPath!.row]
        } else {
            let item = Item()
            
            if itemArray.count != 0 {
                item.id = itemArray.max("id")! + 1
            }
            
            inputViewController.item = item
        }
    }
    
    // Renew the tableView when coming back from the input page
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
}

