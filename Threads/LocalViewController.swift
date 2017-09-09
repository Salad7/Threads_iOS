//
//  LocalViewController.swift
//  Threads
//
//  Created by cci-loaner on 9/8/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import UIKit
import Firebase
import PopupDialog

class LocalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    @IBOutlet weak var subContent: UIView!
    
    @IBAction func postBtn(_ sender: UIButton) {
        
        
        let alert = UIAlertController(title: "Create new thread",
                                      message: "What's on your mind",
                                      preferredStyle: .alert)
        
        // Submit button
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: { (action) -> Void in
            // Get 1st TextField's text
            let textField = alert.textFields![0]
            print(textField.text!)
        })
        
        // Cancel button
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "Type something here"
            textField.clearButtonMode = .whileEditing
        }
        // Add action buttons and present the Alert
        alert.addAction(submitAction)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        

    }
    @IBAction func inviteBtn(_ sender: UIButton) {
    }
    @IBOutlet weak var localTableView: UITableView!
    @IBOutlet weak var threadTit: UILabel!

    var localRef: DatabaseReference!
    var threadCode = ""
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localTableView.delegate = self
        localTableView.dataSource = self
        localRef = Database.database().reference()
        
        
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addFirebaseLocalThreads(){
        _ = localRef.observe(DataEventType.value, with: { (snapshot) in
           
            //If a local thread exists
            if(snapshot.childSnapshot(forPath: "local").exists()){
                if(snapshot.childSnapshot(forPath: "local").childSnapshot(forPath: self.threadCode).exists()){
                    self.messages = (snapshot.childSnapshot(forPath: "local").childSnapshot(forPath: self.threadCode).childSnapshot(forPath: "messages").value as? [Message])!
                    self.localTableView.reloadData()
                }
            }
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "local_cell") as! LocalTableViewCell
        cell.message.text = self.messages[indexPath.row].getMsg()
        cell.replies.text = String(self.messages[indexPath.row].getReplies())
        cell.upvote.text = String(self.messages[indexPath.row].getUpvotes())
        cell.elapsedTime.text = String(describing: self.messages[indexPath.row].getTimeStamp())
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegue(withIdentifier: "show_post", sender: indexPath)
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
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
