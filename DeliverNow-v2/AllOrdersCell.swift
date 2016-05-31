//
//  AllOrdersCell.swift
//  DeliverNow-v2
//
//  Created by 滕施男 on 31/05/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit

class AllOrderCell: UITableViewCell {
    
    @IBOutlet var eatWhatLabel: UILabel!
    @IBOutlet var userAddressLabel: UILabel!
    @IBOutlet var tipLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
