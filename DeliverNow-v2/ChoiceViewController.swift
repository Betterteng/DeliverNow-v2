//
//  ChoiceViewController.swift
//  DeliverNow
//
//  Created by 滕施男 on 6/05/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit

class ChoiceViewController: UIViewController {
    
    
    @IBOutlet var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get current user's ID
        let uid = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        // Retrieve current user's name property
        FIREBASE_REF.observeEventType(.ChildAdded, withBlock: { snapshot in
            let userName = (snapshot.value.objectForKey(uid)?.objectForKey("info")?.objectForKey("name"))! as! String
            // Set the text of userNameLabel
            self.userNameLabel.text = userName
        })
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
