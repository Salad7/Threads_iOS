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

    var threadRef: DatabaseReference!
    
    var topics = [Topics]()
    let defaults = UserDefaults.standard
    var threadCode = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        localTableView.delegate = self
        localTableView.dataSource = self
        self.threadCode = self.defaults.string(forKey: "threadCode")!
        threadRef = Database.database().reference()
        addFirebaseLocalThreads()
        
        
        // Do any additional setup after loading the view.
    }
    
    func loadLocalPosts(){
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addFirebaseLocalThreads(){
        _ = threadRef.observe(DataEventType.value, with: { (snapshot) in
           
            //If a local thread exists
            print("Threads")
            print(self.threadCode)
            if(snapshot.childSnapshot(forPath: "Threads").childSnapshot(forPath: String(self.threadCode)).exists()){
                if(snapshot.childSnapshot(forPath: "Threads").childSnapshot(forPath: String(self.threadCode)).childSnapshot(forPath: "topics").exists())
                   {
                    //print("test fail2")

                    
               self.topics = (snapshot.childSnapshot(forPath: String(self.threadCode)).childSnapshot(forPath: "topics").value as? [Topics])!
                    //print("test fail3")

                   }
                else{
                    var t = Topics.init()
                    t.setParent(pa: self.threadCode)
                    t.setReplies(r: 0)
                    t.setUpvotes(up: 50)
                    t.setPosition(p: 0)
                    t.setAnonCode(a: [UIDevice.current.identifierForVendor!.uuidString:"red"])
                    t.setTimeStamp(t: Date().toMillis())
                    t.setHostUID(uid: UIDevice.current.identifierForVendor!.uuidString)
                    t.setTopicTitle(m: "Hello World")
                    self.createFirstPostAutomatically(t: t)
                    }
            }
            self.localTableView.reloadData()
        })

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "local_cell") as! LocalTableViewCell
        cell.message.text = self.topics[indexPath.row].getTopicTitle()
        cell.replies.text = String(self.topics[indexPath.row].getReplies())
        cell.upvote.text = String(self.topics[indexPath.row].getUpvotes())
        cell.elapsedTime.text = String(describing: self.topics[indexPath.row].getTimeStamp())
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegue(withIdentifier: "show_post", sender: indexPath)
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    func createFirstPostAutomatically(t :Topics){
    self.threadRef.child("Threads").child(self.threadCode).child("topics").child("0").updateChildValues(["parent":t.getParent()])
    self.threadRef.child("Threads").child(self.threadCode).child("topics").child("0").updateChildValues(["UID":t.getHostUID()])
    self.threadRef.child("Threads").child(self.threadCode).child("topics").child("0").updateChildValues(["position":t.getPostion()])
    self.threadRef.child("Threads").child(self.threadCode).child("topics").child("0").updateChildValues(["replies":t.getReplies()])
    self.threadRef.child("Threads").child(self.threadCode).child("topics").child("0").updateChildValues(["upvotes":t.getUpvotes()])
    self.threadRef.child("Threads").child(self.threadCode).child("topics").child("0").updateChildValues(["anonCode":t.getAnonCode()])
    self.threadRef.child("Threads").child(self.threadCode).child("topics").child("0").updateChildValues(["postTitle":t.getPostTitle()])
    self.threadRef.child("Threads").child(self.threadCode).child("topics").child("0").updateChildValues(["timeStamp":t.getTimeStamp()])

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
