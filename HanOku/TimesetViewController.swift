//
//  TimesetViewController.swift
//  HanOku
//
//  Created by tlsmooth89 on 4/22/16.
//  Copyright © 2016 yusuke.iwasaki. All rights reserved.
//

import UIKit

class TimesetViewController: UIViewController {
 
    @IBOutlet weak var myDatePicker: UIDatePicker!
    
    var localNotification = UILocalNotification()
    
    // Making the datePicker work just for the Time
    func timePicker() { myDatePicker.datePickerMode = UIDatePickerMode.Time }
    
    func notificationsOptions() {
        localNotification.fireDate = myDatePicker.date
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.repeatInterval = NSCalendarUnit.Minute // It should be .Day
        // localNotification.alertBody = "\(item.title)"
        localNotification.alertBody = "Every minute notification"
        localNotification.soundName = UILocalNotificationDefaultSoundName
        // localNotification.userInfo = ["id":item.id]
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        timePicker()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        notificationsOptions()
        super.viewWillDisappear(animated)
    }

    /*
    func setNotification(item: Item) {
        
        // Cancelling if the same item has been already registered

         for notification in UIApplication.sharedApplication().scheduledLocalNotifications! {
         if notification.userInfo!["id"] as! Int == item.id {
         UIApplication.sharedApplication().cancelLocalNotification(notification)
         break
         }
         }
    }
    */
}
