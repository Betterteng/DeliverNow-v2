//
//  addOrderController.swift
//  DeliverNow-v2
//
//  Created by 滕施男 on 17/05/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit

class addOrderController: UIViewController {
    
    @IBOutlet var eatWhatTextField: UITextField!
    @IBOutlet var restaurantTextField: UITextField!
    @IBOutlet var livingAddressTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var contactTextField: UITextField!
    @IBOutlet var tipTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Add order information to the Firebase
    @IBAction func submitAction(sender: UIButton) {
        addOrderToUser()
        addOrderToAll()
        alertSubmitSuccessfully()
    }

    /*
     This method will help app go back to previous view.
     */
    @IBAction func backAction(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
     Calls this function when the tap is recognized.
     */
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    /*
     When users don't fill all the TextFields, call this method.
     The method will show an alert to remind users.
     */
    func alertIfHasEmptyInput() -> Void {
        let alert = UIAlertController(title: "Sorry", message: "Empty input cannot be accepted...", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Got it", style: .Default, handler: nil)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    /*
     Remind user they have submit succeessfully.
     */
    func alertSubmitSuccessfully() -> Void {
        let alert = UIAlertController(title: "Congratulations", message: "You've added your order to the list!", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Got it", style: .Default, handler: nil)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    /*
     This method will help user to add orders to their own "Order list".
     */
    func addOrderToUser() -> Void {
        // Extract infromation from the TextFields.
        let eatWhat = self.eatWhatTextField.text
        let restaurant = self.restaurantTextField.text
        let livingAddress = self.livingAddressTextField.text
        let name = self.nameTextField.text
        let contact = self.contactTextField.text
        let tip = self.tipTextField.text
        
        if eatWhat != "" && restaurant != "" && livingAddress != "" && name != "" && contact != "" && tip != "" {
            // Get current user's ID
            let uid = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
            // Retrieve current user's order index property, write order information and reset index
            FIREBASE_REF.observeEventType(.ChildAdded, withBlock: { snapshot in
                var orderIndex = (snapshot.value.objectForKey(uid)?.objectForKey("count")?.objectForKey("index"))! as! Int
                // Append user's order information to Firebase.
                let orderInfo = ["eatWhat" : eatWhat!, "restaurant" : restaurant!, "livingAddress" : livingAddress!, "name" : name!, "tip" : tip!, "status" : "To be delivered", "contact" : contact!]
                FIREBASE_REF.childByAppendingPath("users/\(uid)/orders/\(orderIndex)").setValue(orderInfo)
                // Reset index
                orderIndex += 1
                FIREBASE_REF.childByAppendingPath("users/\(uid)/count/index").setValue(orderIndex)
            })
        } else {
            self.alertIfHasEmptyInput()
        }
    }
    
    /*
     Add user's order to anthor database.
     "Another database" is used to provide info for delivery men.
     */
    func addOrderToAll() -> Void {
        // Extract infromation from the TextFields.
        let eatWhat = self.eatWhatTextField.text
        let restaurant = self.restaurantTextField.text
        let livingAddress = self.livingAddressTextField.text
        let name = self.nameTextField.text
        let contact = self.contactTextField.text
        let tip = self.tipTextField.text
        
        if eatWhat != "" && restaurant != "" && livingAddress != "" && name != "" && contact != "" && tip != "" {
            // Get current user's ID
            let uid = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
            // Retrieve current user's order index property, write order information and reset index
            FIREBASE_REF.observeEventType(.ChildAdded, withBlock: { snapshot in
                var orderIndex = (snapshot.value.objectForKey("index"))! as! Int
                let myOrderIndex = String(orderIndex)
                // Append user's order information to Firebase.
                let orderInfo = ["eatWhat" : eatWhat!, "restaurant" : restaurant!, "livingAddress" : livingAddress!, "name" : name!, "tip" : tip!, "status" : "To be delivered", "userID" : uid, "contact" : contact!]
                FIREBASE_REF.childByAppendingPath("users/allOrders/\(myOrderIndex)").setValue(orderInfo)
                // Reset index
                orderIndex += 1
                FIREBASE_REF.childByAppendingPath("users/index").setValue(orderIndex)
            })
        } else {
            self.alertIfHasEmptyInput()
        }
    }
}