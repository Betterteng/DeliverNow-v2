//
//  UserOrdersTableViewController.swift
//  DeliverNow-v2
//
//  Created by 滕施男 on 22/05/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit

class UserOrdersTableViewController: UITableViewController {
    
    var ordersList: NSMutableArray?
    let userOrdersURL: String = "https://delivernow-monash4039.firebaseio.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersList = NSMutableArray()
        downloadOrders()
    }
    
    
    
    func downloadOrders() -> Void {
        // Get current user's ID
        let uid = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        // Retrieve current user's orders property
        FIREBASE_REF.observeEventType(.ChildAdded, withBlock: { snapshot in
            let userOrdersArray = (snapshot.value.objectForKey(uid)?.objectForKey("orders"))! as! NSArray
            print(userOrdersArray.count)
        })
    }
    
    
    
    /*
     When the view loads, it will begin to download the data.
     This method will send the actual request to the webserver create a session.
     If everything goes well, then it will execute the parseNewJSON method.
     */
    func downloadNewsData() {
        let url: NSURL = NSURL(string: userOrdersURL)!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
            (data, response, error) in
            if (error != nil) {
                let alert = UIAlertController(title: "Sorry!", message: "We may lost network connection:(", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                self.parseNewsJSON(data!)
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            }
        }
        task.resume()
    }
    
    /*
     This method will help us find the information we want, then store them in the NSMutableArray.
     */
    func parseNewsJSON(newsJSON: NSData) {
        do {
            let result = try NSJSONSerialization.JSONObjectWithData(newsJSON, options: NSJSONReadingOptions.MutableContainers)
            // Get current user's ID
            let uid = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
            //Find the data we want.
            let newsArray = result.objectForKey("users")?.objectForKey(uid)?.objectForKey("orders") as! NSArray
            NSLog("Found \(newsArray.count) new news!")
//            for realNews in (newsArray as NSArray as! [NSDictionary]) {
//                let news = News(realNews: realNews)
//                //Store the object we created in the NSMutableArray.
//                newsList!.addObject(news)
//            }
        } catch {
            print("JSON Serialization error")
        }
    }

    /*
     This method will help app go back to previous view.
     */
    @IBAction func backAction(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
