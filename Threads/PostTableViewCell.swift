//
//  PostTableViewCell.swift
//  Threads
//
//  Created by cci-loaner on 9/8/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var anonIcon: UIImageView!
    @IBOutlet weak var upvotes: UILabel!
    @IBOutlet weak var message: UILabel!
    
    @IBAction func upvoteBtn(_ sender: UIButton) {
        if let upvoteBtn = self.upvoteButton
        {
            upvoteBtn()
        }
    }
    var upvoteButton : (() -> Void)? = nil

  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
