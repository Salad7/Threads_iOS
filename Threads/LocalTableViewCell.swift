//
//  LocalTableViewCell.swift
//  Threads
//
//  Created by cci-loaner on 9/8/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import UIKit
import Firebase

class LocalTableViewCell: UITableViewCell {
    @IBOutlet weak var upvoteBtnF: UIButton!
    @IBOutlet weak var elapsedTime: UILabel!
    @IBOutlet weak var replies: UILabel!
    @IBOutlet weak var upvote: UILabel!
    @IBAction func upvoteBtn(_ sender: UIButton) {
        if let upvoteBtn = self.yourobj
        {
            upvoteBtn()
        }
    }
    var local_ref :DatabaseReference!
    @IBOutlet weak var message: UILabel!
    var yourobj : (() -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        local_ref = Database.database().reference()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
