//
//  AllOrdersTableController.swift
//  DeliverNow-v2
//
//  Created by 滕施男 on 24/05/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit
import Firebase

class AllOrdersTableController: UITableViewController {
    
    var ordersList: NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    /*
//     There is only one section in the tableView, so we return 1.
//     */
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return (ordersList?.count)!
//    }
    
    override func viewWillAppear(animated: Bool) {
        ordersList = NSMutableArray()
        downloadOrders()
    }
    
    /*
     Download all orders and put them into the NSMutableArray.
     */
    func downloadOrders() {
        
//        FIREBASE_REF.observeEventType(.ChildAdded, withBlock: { snapshot in
//            // Judge if user has order. If none, popup an alert
//            if snapshot.value.objectForKey("allOrders") == nil {
//                self.alertIfNoneOrders()
//            } else {
////                let userOrdersArray = (snapshot.value.objectForKey("allOrders"))! as! NSArray
////                // Create order objects and put them into the NSMutableArray.
////                
////                print(userOrdersArray.count)
////                
////                
////                for realUserOrders in (userOrdersArray as NSArray as! [NSDictionary]) {
////                    let userOrder = UserOrders(realUserOrders: realUserOrders)
////                    self.ordersList!.addObject(userOrder)
////                    
////                
////                }
//                
//                let xxxxx = (snapshot.value.objectForKey("allOrders")?.objectForKey("0")?.objectForKey("eatWhat"))! as! String
//                print(xxxxx)
//                
//                
//                self.tableView.reloadData()
//            }
//        })
        
        
        
        FIREBASE_REF.observeEventType(.Value, withBlock: { snapshot in
            print(snapshot.value.objectForKey("users")?.objectForKey("allOrders"))
            }, withCancelBlock: { error in
                print(error.description)
        })

       
        
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
