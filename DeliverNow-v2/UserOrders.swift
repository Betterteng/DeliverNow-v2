//
//  UserOrders.swift
//  DeliverNow-v2
//
//  Created by 滕施男 on 18/05/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit

class UserOrders: NSObject {
    
    var eatWhat: String?
    var restaurantAddress: String?
    var livingAddress: String?
    var userName: String?
    var contact: String?
    var tip: String?
    var orderStatement: String?
    
    init(realUserOrders: NSDictionary) {
        self.eatWhat = realUserOrders.objectForKey("eatWhat") as? String
        self.restaurantAddress = realUserOrders.objectForKey("restaurant") as? String
        self.livingAddress = realUserOrders.objectForKey("livingAddress") as? String
        self.userName = realUserOrders.objectForKey("name") as? String
        self.contact = realUserOrders.objectForKey("contact") as? String
        self.tip = realUserOrders.objectForKey("tip") as? String
        self.orderStatement = realUserOrders.objectForKey("status") as? String
    }
}
