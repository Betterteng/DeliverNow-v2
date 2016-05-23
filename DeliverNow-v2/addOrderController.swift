//
//  addOrderController.swift
//  DeliverNow-v2
//
//  Created by 滕施男 on 22/05/2016.
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
    
    @IBAction func submitAction(sender: UIButton) {
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
            // Append user's order information to Firebase.
            let userInfo = ["eatWhat" : eatWhat!, "restaurant" : restaurant!, "livingAddress" : livingAddress!, "name" : name!, "tip" : tip!]
             FIREBASE_REF.childByAppendingPath("users/\(uid)/orders").setValue(userInfo)
        } else {
            self.alertIfHasEmptyInput()
        }
    }

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
}
