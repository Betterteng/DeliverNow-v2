//
//  AllOrdersTableController.swift
//  DeliverNow-v2
//
//  Created by 滕施男 on 24/05/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit

class AllOrdersTableController: UITableViewController {
    
    var ordersList: NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBarButtonItem()
        setBarTitle()
    }
    
    /*
     Set the style of bar button item.
     */
    func setBarButtonItem() -> Void {
        let leftItem = UIBarButtonItem(title: "BACK", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(UserOrdersTableViewController.backAction(_:)))
        if let font = UIFont(name: "Chalkduster", size: 14.0) {
            leftItem.setTitleTextAttributes([NSFontAttributeName: font], forState: UIControlState.Normal)}
        navigationController?.navigationBar.topItem?.leftBarButtonItem = leftItem
    }
    
    /*
     Set the style of bar title.
     */
    func setBarTitle() -> Void {
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor(red: 255.0/255.0, green: 128.0/255.0, blue: 0.0/255.0, alpha: 1.0),
             NSFontAttributeName: UIFont(name: "Chalkduster", size: 21)!]
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
     Download all orders and put them into the NSMutableArray.
     */
    func downloadOrders() {
        
        FIREBASE_REF.observeEventType(.ChildAdded, withBlock: { snapshot in
            // Judge if user has order. If none, popup an alert
            if snapshot.value.objectForKey("allOrders") == nil {
                self.alertIfNoneOrders()
            } else {
                let userOrdersArray = (snapshot.value.objectForKey("allOrders"))! as! NSArray
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
        let cell = self.tableView.dequeueReusableCellWithIdentifier("AllOrderCell", forIndexPath: indexPath) as! AllOrderCell
        // Configure the cell...
        let userOrder: UserOrders = ordersList![indexPath.row] as! UserOrders
        // Set eatWhat label.
        if (userOrder.eatWhat != nil) {
            cell.eatWhatLabel.text = userOrder.eatWhat
        }
        // Set living address label.
        if (userOrder.livingAddress != nil) {
            cell.userAddressLabel.text = userOrder.livingAddress
        }
        // Set tip label.
        if (userOrder.tip != nil) {
            cell.tipLabel.text = userOrder.tip
        }
        return cell
    }
    
    /*
     Pass order object to OrderDetailAllController.
     */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showOrderDetailAllSegue") {
            let controller: OrderDetailAllController = segue.destinationViewController as! OrderDetailAllController
            let order: UserOrders = self.ordersList![(self.tableView.indexPathForSelectedRow?.row)!] as! UserOrders
            controller.order = order
        }
    }
    
    /*
     Popup an alert if doesn't have any orders.
     */
    func alertIfNoneOrders() -> Void {
        let alert = UIAlertController(title: "Sorry", message: "You don't have any orders...", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Got it", style: .Default, handler: nil)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }

    @IBAction func backAction(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
