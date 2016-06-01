//
//  OrderDetailUserController.swift
//  DeliverNow-v2
//
//  Created by 滕施男 on 1/06/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit

class OrderDetailUserController: UIViewController {
    
    @IBOutlet var eatWhatLabel: UILabel!
    @IBOutlet var rAddLabel: UILabel!
    @IBOutlet var cAddLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var contactLabel: UILabel!
    @IBOutlet var tipLabel: UILabel!
    
    var order: UserOrders?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the labels.
        setLabels()
    }
    
    /*
     Set labels.
     */
    func setLabels() -> Void {
        eatWhatLabel.text = order?.eatWhat
        rAddLabel.text = order?.restaurantAddress
        cAddLabel.text = order?.livingAddress
        nameLabel.text = order?.userName
        contactLabel.text = order?.contact
        tipLabel.text = order?.tip
    }

    @IBAction func backAction(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
