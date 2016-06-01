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
        setUserName()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     Set userName label.
     */
    func setUserName() -> Void {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        FIREBASE_REF.observeEventType(.ChildAdded, withBlock: { snapshot in
            let userName = (snapshot.value.objectForKey(userID)?.objectForKey("info")?.objectForKey("name"))! as! String
            self.userNameLabel.text = userName
        })
    }
}
