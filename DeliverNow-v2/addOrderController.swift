//
//  addOrderController.swift
//  DeliverNow-v2
//
//  Created by 滕施男 on 22/05/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit

class addOrderController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
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
}
