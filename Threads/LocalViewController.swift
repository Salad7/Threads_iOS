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
    var positionHit = 10
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
            //print("Threads")
            //print(self.threadCode)
            if(snapshot.childSnapshot(forPath: "Threads").childSnapshot(forPath: String(self.threadCode)).exists()){
                let threadPath = snapshot.childSnapshot(forPath: "Threads").childSnapshot(forPath: String(self.threadCode))
                self.threadTit.text = threadPath.childSnapshot(forPath: "threadTitle").value as! String

                if(snapshot.childSnapshot(forPath: "Threads").childSnapshot(forPath: String(self.threadCode)).childSnapshot(forPath: "topics").exists())
                   {
                      let topicPath = snapshot.childSnapshot(forPath: "Threads").childSnapshot(forPath: String(self.threadCode)).childSnapshot(forPath: "topics")
                    for i in 0 ... FirebaseCounter().MAX_TOPICS {
                        let totalTopics = Int(topicPath.childrenCount)
                        var topicsFound = 0
                        if(topicPath.childSnapshot(forPath: String(i)).exists() && totalTopics >= topicsFound){
                            let specificThreadPath = topicPath.childSnapshot(forPath: String(i))
                            var topic = Topics()
                            
                            topic.setTopicTitle(tp: specificThreadPath.childSnapshot(forPath: "topicTitle").value as! String)
                            topic.setPosition(p: specificThreadPath.childSnapshot(forPath: "position").value as! Int)
                            topic.setUpvotes(up: specificThreadPath.childSnapshot(forPath: "upvotes").value as! Int)
                            topic.setReplies(r: specificThreadPath.childSnapshot(forPath: "replies").value as! Int)
                            topic.setTimeStamp(t: specificThreadPath.childSnapshot(forPath: "timeStamp").value as! UInt64)
                            topic.setParent(pa: specificThreadPath.childSnapshot(forPath: "parent").value as! String)
                            topic.setHostUID(uid: specificThreadPath.childSnapshot(forPath: "UID").value as! String)
                            topic.setAnonCode(a: specificThreadPath.childSnapshot(forPath: "anonCode").value as! [String:String])
                            self.topics.append(topic)
                            topicsFound = topicsFound + 1
                        }
                        
                    }
                  
                    


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
        cell.replies.text = String(self.topics[indexPath.row].getReplies()) + " replies"
        cell.upvote.text = String(String(self.topics[indexPath.row].getUpvotes()))
        cell.elapsedTime.text = String(describing: self.topics[indexPath.row].getTimeStamp())
        print("wired cell as "+cell.elapsedTime.text!)
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        positionHit = indexPath.row
        DispatchQueue.main.async(execute: {
            self.performSegue(withIdentifier: "show_post", sender: indexPath)
            print("hit")
        })

        
        
    }
    
    func removeListener(){
        threadRef.removeAllObservers()
    }
    
    
     //MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "show_post"){
            let vc = segue.destination as! PostViewController
            let topic = self.topics[positionHit]
            //print(topic.getMessages())
            //print("threadTitle " + "dsadasdas " + vc.threadTitle.text! )
            vc.topicPosition = positionHit
            vc.threadt = threadTit.text!///
            vc.msg = topic.getTopicTitle()
            vc.up = String(topic.getUpvotes())
            vc.reps = String(topic.getReplies())
            vc.time = String(topic.getTimeStamp())
            //self.dismiss(animated: true, completion: nil)
            removeListener()
        }
    }
    

}
