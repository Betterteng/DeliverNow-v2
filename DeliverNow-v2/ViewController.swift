//
//  ViewController.swift
//  DeliverNow
//
//  Created by 滕施男 on 4/05/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var logoutButton: UIButton!
    @IBOutlet var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.setEmailTextField()
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(animated: Bool) {
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && CURRENT_USER.authData != nil {
            self.logoutButton.hidden = false
            // Get current user's ID
            let uid = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
            // Retrieve current user's name and email property
            FIREBASE_REF.observeEventType(.ChildAdded, withBlock: { snapshot in
                let userName = (snapshot.value.objectForKey(uid)?.objectForKey("info")?.objectForKey("name"))! as! String
                let userEmail = (snapshot.value.objectForKey(uid)?.objectForKey("info")?.objectForKey("email"))! as! String
                // Set the text of userNameLabel and emailTextField
                self.userNameLabel.text = userName
                self.emailTextField.text = userEmail
            })
        } else {
            self.userNameLabel.text = "No one logged in now..."
        }
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
     If everything is ok, record the login state of current user and show the logout button.
     If users' input is invalid, let system popup relative alert to remind users.
     */
    @IBAction func loginAction(sender: UIButton) {
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        
        if email != "" && password != "" {
            FIREBASE_REF.authUser(email, password: password, withCompletionBlock: { (error, authData) -> Void in
                if error == nil {
                    //Record the login state of current user.
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    print("Logged in succeessfully with the userID: \(authData.uid)")
                    
                    // Jump to the welcome page.
                    self.jumpToWelcomePage()
                    // Hide the logout button.
                    self.logoutButton.hidden = false
                } else {
                    print(error.description)
                    //Check if info in the TextFields can match with the info in Firebase.
                    self.checkLoginInput(error.description)
                }
            })
        } else {
            self.ifIsEmpty()
        }
    }
    
    /*
     Loguot current user and hide the logout button in the View.
     Change the text of userNameLabel.
     */
    @IBAction func logoutAction(sender: UIButton) {
        CURRENT_USER.unauth()
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
        self.logoutButton.hidden = true
        userNameLabel.text = "No one logged in now..."
    }
    
    /*
     This method will let system popup differt alerts to remind users
     depending on "error code (returned by Firebase)".
     */
    func checkLoginInput(error: String) -> Void {
        if error.rangeOfString("-5") != nil {
            let alert = UIAlertController(title: "Sorry", message: "The specified email address is invalid...", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Got it", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        } else if error.rangeOfString("-6") != nil {
            let alert = UIAlertController(title: "Sorry", message: "The specified password is incorrect...", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Got it", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        } else if error.rangeOfString("-8") != nil {
            let alert = UIAlertController(title: "Sorry", message: "The specified user does not exist...", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Got it", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    /*
     Call this method if users don't finish fillig the blanks.
     This method will let system popup an alert to reminder users.
     */
    func ifIsEmpty() -> Void {
        let alert = UIAlertController(title: "Sorry", message: "Empty input cannot be accepted...", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Got it", style: .Default, handler: nil)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    /*
     This method will jump to Welcome page(ChoiceView) from main view.
     */
    func jumpToWelcomePage() -> Void {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyboard.instantiateViewControllerWithIdentifier("WelcomPageVC") as UIViewController
        self.presentViewController(secondViewController, animated: true, completion: nil)
    }
    
    /*
     Set the text of emailTextField depending on current user.
     */
    func setEmailTextField() -> Void {
        // If there has been a user logged into the application
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && CURRENT_USER.authData != nil {
            // Get current user's ID
            let uid = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
            // Retrieve current user's email property
            FIREBASE_REF.observeEventType(.ChildAdded, withBlock: { snapshot in
                let userEmail = (snapshot.value.objectForKey(uid)?.objectForKey("info")?.objectForKey("email"))! as! String
                self.emailTextField.text = userEmail
            })
        }
    }
}
