//
//  UserOrdersTableViewController.swift
//  DeliverNow-v2
//
//  Created by 滕施男 on 18/05/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit

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
        print(ordersList?.count)
        return (ordersList?.count)!
    }
    
    override func viewWillAppear(animated: Bool) {
        ordersList = NSMutableArray()
        downloadOrders()
        //self.tableView.reloadData()
    }

    
    func downloadOrders() {
        // Get current user's ID
        let uid = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        // Retrieve current user's orders property
        FIREBASE_REF.observeEventType(.ChildAdded, withBlock: { snapshot in
            let userOrdersArray = (snapshot.value.objectForKey(uid)?.objectForKey("orders"))! as! NSArray
            print(userOrdersArray.count)
            
            for realUserOrders in (userOrdersArray as NSArray as! [NSDictionary]) {
                let userOrder = UserOrders(realUserOrders: realUserOrders)
                
                //Store the object we created in the NSMutableArray.
                self.ordersList!.addObject(userOrder)
            }
            self.tableView.reloadData()
        })
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("UserOrdersCell", forIndexPath: indexPath) as! UserOrderCell
        
        // Configure the cell...
        let userOrder: UserOrders = ordersList![indexPath.row] as! UserOrders
        
        if (userOrder.eatWhat != nil) {
            cell.eatWhatLabel.text = userOrder.eatWhat
            print(userOrder.eatWhat)
        }
        if (userOrder.orderStatement != nil) {
            cell.orderStatementLabel.text = userOrder.orderStatement
            print(userOrder.orderStatement)
        }
        return cell
    }

    /*
     This method will help app go back to previous view.
     */
    @IBAction func backAction(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
