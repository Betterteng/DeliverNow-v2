//
//  BaseService.swift
//  DeliverNow-v2
//
//  Created by 滕施男 on 7/05/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import Foundation
import Firebase

let BASE_URL = "https://delivernow-monash4039.firebaseio.com"
let FIREBASE_REF = Firebase(url: BASE_URL)

var CURRENT_USER: Firebase {
    let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
    let currentUser = Firebase(url: "\(FIREBASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
    return currentUser!
}
