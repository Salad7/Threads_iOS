//
//  SettingsTableViewCell.swift
//  Threads
//
//  Created by cci-loaner on 9/8/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    @IBAction func settings(_ sender: UIButton) {
    }
    @IBOutlet weak var name: UILabel!

    @IBOutlet weak var dateCreated: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
