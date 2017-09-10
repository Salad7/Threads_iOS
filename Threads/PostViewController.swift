//
//  PostViewController.swift
//  Threads
//
//  Created by cci-loaner on 9/8/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import UIKit
import Firebase
import Letters
class PostViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    //@IBOutlet weak var postTableView: UITableView!
    @IBAction func sendBtn(_ sender: UIButton) {
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
    var topicPosition = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        postTableView.dataSource = self
        postTableView.delegate = self
        postRef = Database.database().reference()
        threadTitle.text = threadt
        message.text = msg
        timeElapsed.text = time
        upvotes.text = up
        replies.text = reps

        // Do any additional setup after loading the view.
    }

    func loadPosts(){
        _ = postRef.observe(DataEventType.value, with: { (snapshot) in
            
            //1
            if(snapshot.childSnapshot(forPath: "Threads").childSnapshot(forPath: String(self.threadCode)).exists()){
              
                let threadPath = snapshot.childSnapshot(forPath: "Threads").childSnapshot(forPath: String(self.threadCode))
                //2
                if(threadPath.childSnapshot(forPath: "topics").exists())
                {
                    let topicPath = snapshot.childSnapshot(forPath: "Threads").childSnapshot(forPath: String(self.threadCode)).childSnapshot(forPath: "topics")
                    //3
                    if(topicPath.childSnapshot(forPath: String(self.topicPosition)).childSnapshot(forPath: "messages").exists()){
                        let messagesPath = topicPath.childSnapshot(forPath: String(self.topicPosition)).childSnapshot(forPath: "messages")
                        let totalMessages = Int(messagesPath.childrenCount)
                        var messagesFound = 0
                        //4
                        for i in 0 ... FirebaseCounter().MAX_MESSAGES_PER_TOPIC {
                            //5
                            if(messagesPath.childSnapshot(forPath: String(i)).exists() && totalMessages >= messagesFound){
                            let specificMessagePath = messagesPath.childSnapshot(forPath: String(i))
                            var message = Message()
                            
                            message.setMsg(m: specificMessagePath.childSnapshot(forPath: "message").value as! String)
                            message.setPosition(p: specificMessagePath.childSnapshot(forPath: "position").value as! Int)
                            message.setUpvotes(u: specificMessagePath.childSnapshot(forPath: "upvotes").value as! Int)
                            message.setReplies(r: specificMessagePath.childSnapshot(forPath: "replies").value as! Int)
                            message.setTimeStamp(t: specificMessagePath.childSnapshot(forPath: "timeStamp").value as! UInt64)
                            message.setAnonCode(a: specificMessagePath.childSnapshot(forPath: "anonCode").value as! [String:String])
                            self.messages.append(message)
                            messagesFound = messagesFound + 1
                            }//5
                        }//4
                    }//3
                }//2
            }//1
            self.postTableView.reloadData()
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
        cell.upvotes.text = String(String(self.messages[indexPath.row].getUpvotes()))
        cell.anonIcon?.setImage(string: "M",color: nil, circular: true)
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //performSegue(withIdentifier: "show_post", sender: indexPath)
        //tableView.deselectRow(at: indexPath as IndexPath, animated: true)
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
