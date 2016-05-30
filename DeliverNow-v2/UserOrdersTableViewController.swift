//
//  UserOrdersTableViewController.swift
//  DeliverNow-v2
//
//  Created by 滕施男 on 18/05/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit
import Darwin

class UserOrdersTableViewController: UITableViewController {
    
    var ordersList: NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
     There is only one section in the tableView, so we return 1.
     */
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (ordersList?.count)!
    }
    
    override func viewWillAppear(animated: Bool) {
        ordersList = NSMutableArray()
        downloadOrders()
    }

    /*
     Download user's orders and put them into the NSMutableArray.
     */
    func downloadOrders() {
        // Get current user's ID
        let uid = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        // Retrieve current user's orders property
        FIREBASE_REF.observeEventType(.ChildAdded, withBlock: { snapshot in
            // Judge if user has order. If none, popup an alert
            if snapshot.value.objectForKey(uid)?.objectForKey("orders") == nil {
                self.alertIfNoneOrders()
            } else {
                let userOrdersArray = (snapshot.value.objectForKey(uid)?.objectForKey("orders"))! as! NSArray
                // Create order objects and put them into the NSMutableArray.
                for realUserOrders in (userOrdersArray as NSArray as! [NSDictionary]) {
                    let userOrder = UserOrders(realUserOrders: realUserOrders)
                    self.ordersList!.addObject(userOrder)
                }
                self.tableView.reloadData()
            }
        })
    }
    
    /*
     Configure the cells.
     */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("UserOrdersCell", forIndexPath: indexPath) as! UserOrderCell
        // Configure the cell...
        let userOrder: UserOrders = ordersList![indexPath.row] as! UserOrders
        // Set eatWhat label.
        if (userOrder.eatWhat != nil) {
            cell.eatWhatLabel.text = userOrder.eatWhat
        }
        // Set order statement label.
        if (userOrder.orderStatement != nil) {
            cell.orderStatementLabel.text = userOrder.orderStatement
        }
        return cell
    }

    /*
     This method will help app go back to previous view.
     */
    @IBAction func backAction(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
     Popup an alert if user doesn't have any orders.
     */
    func alertIfNoneOrders() -> Void {
        let alert = UIAlertController(title: "Sorry", message: "You don't have any orders...", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Got it", style: .Default, handler: nil)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
