//
//  PostViewController.swift
//  Threads
//
//  Created by cci-loaner on 9/8/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import UIKit
import Firebase
class PostViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBAction func linkBtn(_ sender: UIButton) {
        //invite code stored in inviteCode
        performSegue(withIdentifier: "show_contacts", sender: nil)
        
    }
    @IBAction func `return`(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var threadTitle: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var timeElapsed: UILabel!
    @IBAction func upvoteBtn(_ sender: UIButton) {
    }
    @IBOutlet weak var replies: UILabel!
    @IBOutlet weak var upvotes: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
    @IBAction func returnBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "show_tab", sender: nil)
    }
    //@IBOutlet weak var postTableView: UITableView!
    @IBAction func sendBtn(_ sender: UIButton) {
        
        DispatchQueue.main.async(execute: {
        //if we enter something in our message
        if(self.textView.text.characters.count > 0){
            let newMessagePath = self.postRef.child("Threads").child(self.threadCode).child("topics").child(String(self.topicPosition)).child("messages").child(String(self.messagePosition))
            //print("sendBtn")
            //var currentMessages = messages
            let message = Message()
            message.setMsg(m: self.textView.text)
            message.setHostUID(h: "".getUID())
            message.setReplies(r: 0)
            message.setUpvotes(u: 0)
            message.setTimeStamp(t: Date().toMillis())
            message.setAnonCode(a: ["".getUID():"blue"])
            message.setPosition(p: self.messagePosition)
            //currentMessages.append(message)
            newMessagePath.updateChildValues(["UID":message.getHostUID()])
            newMessagePath.updateChildValues(["timeStamp":message.getTimeStamp()])
            newMessagePath.updateChildValues(["upvotes":message.getUpvotes()])
            newMessagePath.updateChildValues(["replies":message.getReplies()])
            newMessagePath.updateChildValues(["message":message.getMsg()])
            newMessagePath.updateChildValues(["position":message.getPosition()])
            newMessagePath.child("anonCode").updateChildValues(["".getUID():"red"])
            self.textView.text = ""
            //self.replies.text = String(message.replies + 1)
            print("done with stuff")
            self.postRef.removeAllObservers()
            self.loadPosts()
            }
        })
      //Threads--Topics--TopicPosition--Messages--MessagesPosition--update
        
    }
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var postTableView: UITableView!
    var messages = [Message]()
    var postRef: DatabaseReference!
    let defaults = UserDefaults.standard
    var threadCode = ""
    var threadt = ""
    var msg = ""
    var reps = ""
    var time = ""
    var up = ""
    var topicPosition = 999
    var messagePosition = 999
    var messageSelectedInArray = 0
    var inviteCode = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        postTableView.tableFooterView = UIView()
        threadCode = defaults.string(forKey: "threadCode")!
        print("PostViewController threadCode " + String(threadCode))
        print("PostViewController topic position " + String(topicPosition))

        postTableView.dataSource = self
        postTableView.delegate = self
        postRef = Database.database().reference()
        threadTitle.text = threadt
        message.text = msg
        timeElapsed.text = "".getElapsedTime(userTS: Int(time)!)
        upvotes.text = "OP"
        replies.text = reps + " replies"
        loadPosts()
        //userIcon.setImage(string: "D",color: nil,circular: true)
    }
    
    

    func loadPosts(){
        _ = postRef.observe(DataEventType.value, with: { (snapshot) in
              DispatchQueue.main.async {
            var currentLowest = -1
            //1
            self.messages.removeAll()
            //print("loading posts")
            if(snapshot.childSnapshot(forPath: "Threads").childSnapshot(forPath: String(self.threadCode)).exists()){
                let threadPath = snapshot.childSnapshot(forPath: "Threads").childSnapshot(forPath: String(self.threadCode))
                //2
                if(threadPath.childSnapshot(forPath: "topics").exists())
                {
                    //print(" topic path exists")
                    let topicPath = snapshot.childSnapshot(forPath: "Threads").childSnapshot(forPath: String(self.threadCode)).childSnapshot(forPath: "topics")
                    //print("topic position " + String(self.topicPosition))
                    //3
                    if(topicPath.childSnapshot(forPath: String(self.topicPosition)).childSnapshot(forPath: "messages").exists()){
                        let messagesPath = topicPath.childSnapshot(forPath: String(self.topicPosition)).childSnapshot(forPath: "messages")
                        let totalMessages = Int(messagesPath.childrenCount)
                        var messagesFound = 0
                        print(String(totalMessages) + " Messages found!")
                        //4
                        for i in 0 ... FirebaseCounter().MAX_MESSAGES_PER_TOPIC {
                            self.replies.text = String(messagesPath.childrenCount) + " replies"
                            //5
                            if(messagesPath.childSnapshot(forPath: String(i)).exists() && totalMessages >= messagesFound ){
                            let specificMessagePath = messagesPath.childSnapshot(forPath: String(i))
                               // if(specificMessagePath.childSnapshot(forPath: "anonCode").value as? [String:String] != nil){
                            let message = Message()
                                    if(specificMessagePath.childSnapshot(forPath: "upvoters").exists()){
                                        message.setUpvoters(u: specificMessagePath.childSnapshot(forPath: "upvoters").value as! [String])
                                    }
                            if let m = specificMessagePath.childSnapshot(forPath: "message").value as? String {
                            message.setMsg(m: m)
                                }
                            message.setPosition(p: i)
                             if let rep = specificMessagePath.childSnapshot(forPath: "replies").value as? Int {
                            message.setReplies(r:  rep)
                                }
                            if let ts = specificMessagePath.childSnapshot(forPath: "timeStamp").value as? Int {
                            message.setTimeStamp(t: ts)
                                }
                            //message.setAnonCode(a: specificMessagePath.childSnapshot(forPath: "anonCode").value as! [String:String])
                            self.messages.append(message)
                            messagesFound = messagesFound + 1
                                //}
                            }//5
                            //else if we find lowest open positon
                            else {
                                if(currentLowest == -1){
                                   // print("lowest we found was " + String(self.messagePosition))
                                    currentLowest = i
                                    self.messagePosition = i
                                }
                                else if(i < self.messagePosition){
                                   // currentLowest = i
                                }
                            }
                        }//4
                    }//3
                    else{
                        //no messages
                        self.messagePosition = 0
                    }
                }//2
            }//1
            self.postTableView.reloadData()
                 }
        })

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "post_cell") as! PostTableViewCell
        cell.message.text = self.messages[indexPath.row].getMsg()
        cell.upvotes.text = String(String(self.messages[indexPath.row].getUpvoters().count))
        var temp = self.messages[indexPath.row].getUpvoters()
        cell.upvoteButton = {
            //Check if user already upvoted
            if(temp.count == 0 || !temp.contains("".getUID())){
                temp.append("".getUID())
                self.postRef.child("Threads").child(self.threadCode).child("topics").child(String(self.topicPosition)).child("messages").child(String(self.messages[indexPath.row].getPosition())).updateChildValues(["upvoters":temp])
                print("adding child")
            }
            
        }
        //cell.anonIcon?.setImage(string: "M",color: nil, circular: true)
        
        return cell
    }
    
    
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "show_contacts"){
            let contactsVC = segue.destination as! ContactViewController
            contactsVC.threadInvite = self.inviteCode
        }
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
