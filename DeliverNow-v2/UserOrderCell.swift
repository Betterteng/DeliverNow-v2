//
//  UserOrderCell.swift
//  DeliverNow-v2
//
//  Created by 滕施男 on 18/05/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit

class UserOrderCell: UITableViewCell {
    
    @IBOutlet var eatWhatLabel: UILabel!
    @IBOutlet var orderStatementLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

