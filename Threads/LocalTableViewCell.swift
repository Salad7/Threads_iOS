//
//  LocalTableViewCell.swift
//  Threads
//
//  Created by cci-loaner on 9/8/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import UIKit

class LocalTableViewCell: UITableViewCell {
    @IBOutlet weak var elapsedTime: UILabel!
    @IBOutlet weak var replies: UILabel!
    @IBOutlet weak var upvote: UILabel!
    @IBAction func upvoteBtn(_ sender: UIButton) {
    }
    @IBOutlet weak var message: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
