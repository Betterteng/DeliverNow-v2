//
//  OrderDetailAllController.swift
//  DeliverNow-v2
//
//  Created by 滕施男 on 1/06/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class OrderDetailAllController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var eatWhatLabel: UILabel!
    @IBOutlet var rAddLabel: UILabel!
    @IBOutlet var cAddLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var contactLabel: UILabel!
    @IBOutlet var tipLabel: UILabel!
    
    var order: UserOrders?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
     Make a phone call to customer.
     */
    @IBAction func callUser(sender: UIButton) {
        let number = (order?.contact)!
        //print(number)
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(number)")!)
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
    
    /*
     Pass customer's living address to MapController view.
     */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "getLocationSegue") {
            let controller: MapController = segue.destinationViewController as! MapController
            let address: String = order!.livingAddress!
            controller.customerLivingAddress = address
        }
    }
    
    /*
     Back to previous view.
     */
    @IBAction func backAction(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
