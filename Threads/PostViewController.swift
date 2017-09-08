//
//  PostViewController.swift
//  Threads
//
//  Created by cci-loaner on 9/8/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    @IBOutlet weak var threadTitle: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var timeElapsed: UILabel!
    @IBAction func upvoteBtn(_ sender: UIButton) {
    }
    @IBOutlet weak var replies: UILabel!
    @IBOutlet weak var upvotes: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
    @IBAction func returnBtn(_ sender: UIButton) {
    }
    @IBAction func sendBtn(_ sender: UIButton) {
    }
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var postTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
