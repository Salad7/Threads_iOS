//
//  ContactTableViewCell.swift
//  Threads
//
//  Created by cci-loaner on 11/6/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet var contactInital: UILabel!
    @IBOutlet var contactName: UILabel!
    @IBOutlet var phoneNumber: UILabel!
    @IBOutlet var `switch`: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
