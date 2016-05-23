//
//  SignUpViewController.swift
//  DeliverNow
//
//  Created by 滕施男 on 4/05/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet var realNameTextFiled: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPassworTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var mobilePhoneTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    /*
     Calls this function when the tap is recognized.
     */
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     This method will save user's information into the Firebase
     and record user's login state.
     */
    @IBAction func submitAction(sender: UIButton) {
        // Extract information from the TextFields.
        let name = self.realNameTextFiled.text
        let password = self.passwordTextField.text
        let confirmPassword = self.confirmPassworTextField.text
        let address = self.addressTextField.text
        let mobilePhone = self.mobilePhoneTextField.text
        let email = self.emailTextField.text
        
        if password != confirmPassword {
            self.alertConfirmPassword()
        } else if name != "" && password != "" && confirmPassword != "" && address != "" && mobilePhone != "" && email != "" {
            FIREBASE_REF.createUser(email, password: password, withValueCompletionBlock: { (error, result) -> Void in
                if error == nil {
                    FIREBASE_REF.authUser(email, password: password, withCompletionBlock: { (error, authData) -> Void in
                        if error == nil {
                            // Record user's login state.
                            NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                            // Retrieve current user's user ID.
                            let uid = result["uid"] as? String
                            // Append user's information to Firebase.
                            let userInfo = ["name" : name!, "password" : password!, "address" : address!, "mobilePhone" : mobilePhone!, "email" : email!]
                            FIREBASE_REF.childByAppendingPath("users/\(uid!)/info").setValue(userInfo)
                            // Append user's order index
                            let index = 0
                            let orderIndex = ["index": index]
                            FIREBASE_REF.childByAppendingPath("users/\(uid!)/count").setValue(orderIndex)
                            // Remind user that they have registered successfully.
                            self.alertRegisterSuccessfully()
                            print("Account registered successfully with the userID: \(uid!)")
                        } else {
                            print(error)
                        }
                    })
                } else {
                    print(error)
                    self.checkRegisterInput(error.description)
                }
            })
        } else {
            self.alertIfHasEmptyInput()
        }
    }
    
    /*
     Jump to the main view (Login page).
     */
    @IBAction func cancelAction(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
     When password doesn't match the confirmPassword, call this method.
     The method will show an alert to remind users.
     */
    func alertConfirmPassword() -> Void {
        let alert = UIAlertController(title: "Sorry", message: "Confirm Password Incorrectly...", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Got it", style: .Default, handler: nil)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
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
     When user register successfully, system will popup an alert to remind users.
     */
    func alertRegisterSuccessfully() -> Void {
        let alert = UIAlertController(title: "Congratulations", message: "You've registered successfully!", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Got it", style: .Default, handler: nil)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func checkRegisterInput(error: String) -> Void {
        if error.rangeOfString("-9") != nil {
            let alert = UIAlertController(title: "Sorry", message: "The specified email address is already in use...", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Got it", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
