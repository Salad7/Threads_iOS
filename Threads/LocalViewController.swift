//
//  LocalViewController.swift
//  Threads
//
//  Created by cci-loaner on 9/8/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import UIKit
import Firebase
import SwiftSpinner

import PopupDialog

class LocalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
   
    
    
    @IBAction func postBtn(_ sender: UIButton) {
        
        
        let alert = UIAlertController(title: "Create new thread",
                                      message: "What's on your mind",
                                      preferredStyle: .alert)
        
        // Submit button
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: { (action) -> Void in
            SwiftSpinner.show("Creating Thread")
            let ud = self.randomString(length: 5)
            // for i in 0 ... 4 {
                print("thread code is " + self.threadCode)
            self.threadRef.child("Threads").child(self.threadCode).updateChildValues(["threadTitle" :self.threadTit.text!])
            self.threadRef.child("Threads").child(self.threadCode).child("topics").child(String(self.topicPosition)).child("anonCode").updateChildValues(["".getUID():"red"])
      
            self.threadRef.child("Threads").child(self.threadCode).child("topics").child(String(self.topicPosition)).updateChildValues(["parent":self.defaults.string(forKey: "threadCode")])
            self.threadRef.child("Threads").child(self.threadCode).child("topics").child(String(self.topicPosition)).updateChildValues(["UID":"".getUID()])
            self.threadRef.child("Threads").child(self.threadCode).child("topics").child(String(self.topicPosition)).updateChildValues(["position":self.topicPosition])
            self.threadRef.child("Threads").child(self.threadCode).child("topics").child(String(self.topicPosition)).updateChildValues(["replies":0])
            self.threadRef.child("Threads").child(self.threadCode).child("topics").child(String(self.topicPosition)).updateChildValues(["upvotes":0])
            self.threadRef.child("Threads").child(self.threadCode).child("topics").child(String(self.topicPosition)).updateChildValues(["topicTitle": alert.textFields![0].text])
            self.threadRef.child("Threads").child(self.threadCode).child("topics").child(String(self.topicPosition)).updateChildValues(["timeStamp":Date().toMillis()])
            self.threadRef.child("Threads").child(self.threadCode).updateChildValues(["UIDs" :"".getUID()])
            self.threadRef.child("Threads").child(self.threadCode).child("topics").child(String(self.topicPosition)).updateChildValues(["threadInvite":ud])
        self.threadRef.child("Invites").child(ud).setValue(self.threadCode+">"+String(self.topicPosition))
            
            
            //}
            //self.threadRef.removeAllObservers()
            //self.addFirebaseLocalThreads()
           
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
        let alert = UIAlertController(title: "Invited to a thread?",
                                      message: "",
                                      preferredStyle: .alert)
        
        // Submit button
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: { (action) -> Void in
            
        })
        
        // Cancel button
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "Enter invite code here to join"
            textField.clearButtonMode = .whileEditing
        }
        // Add action buttons and present the Alert
        alert.addAction(submitAction)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)

    }
    @IBOutlet weak var localTableView: UITableView!
    @IBOutlet weak var threadTit: UILabel!

    var threadRef: DatabaseReference!
    var firstOpenSpotInTopics = -99
    var topicPosition = 0
    var currentLowest = -1
    var threadPath :DataSnapshot!
    var topics = [Topics]()
    let defaults = UserDefaults.standard
    var threadCode = ""
    var positionHit = 10
    var upvoters = [String]()
    var topicSelectedInList = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localTableView.tableFooterView = UIView()

        localTableView.delegate = self
        localTableView.dataSource = self
        self.threadCode = self.defaults.string(forKey: "threadCode")!
        threadRef = Database.database().reference()
        addFirebaseLocalThreads()
        
        
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addFirebaseLocalThreadsPython(){
        
    }
    //1
    func addFirebaseLocalThreads(){
        //If the user is not in this thread add them
        
        
        _ = threadRef.observe(DataEventType.value, with: { (snapshot) in
           self.topics.removeAll()
            //The user has never joined a thread
            //1
            //If the thread the user is assigned too exists
            var locUpvoters = [String]()
            if(snapshot.childSnapshot(forPath: "Threads").childSnapshot(forPath: String(self.threadCode)).exists()){
                //Store the thread path to shorten code requirements
                self.threadPath = snapshot.childSnapshot(forPath: "Threads").childSnapshot(forPath: String(self.threadCode))
                //Set the title to the title of the threadTitle
                self.threadTit.text = self.threadPath.childSnapshot(forPath: "threadTitle").value as? String
               

                //2
                if(self.threadPath.childSnapshot(forPath: "topics").exists())
                   {
                      let topicPath = snapshot.childSnapshot(forPath: "Threads").childSnapshot(forPath: String(self.threadCode)).childSnapshot(forPath: "topics")
                    //3
                    for i in 0 ... FirebaseCounter().MAX_TOPICS {
                        let totalTopics = Int(topicPath.childrenCount)
                        var topicsFound = 0
                        
                        if((self.threadPath.childSnapshot(forPath: "topics").childSnapshot(forPath: String(i)).childSnapshot(forPath: "upvoters")).exists()){
                          
                            locUpvoters =  (self.threadPath.childSnapshot(forPath: "topics").childSnapshot(forPath: String(i)).childSnapshot(forPath: "upvoters").value as? [String])!
                              print("upvoters exists! value is " + String(locUpvoters.count))
                        }
                        //4
                        if(topicPath.childSnapshot(forPath: String(i)).exists() && totalTopics >= topicsFound){
                            let specificThreadPath = topicPath.childSnapshot(forPath: String(i))
                            let topic = Topics()
                            //5
                            if(specificThreadPath.childSnapshot(forPath: "topicTitle").exists() && specificThreadPath.childSnapshot(forPath: "timeStamp").exists()){
                           
                            topic.setAnonCode(a: specificThreadPath.childSnapshot(forPath: "anonCode").value as! [String:String])
                            topic.setTopicTitle(tp: (specificThreadPath.childSnapshot(forPath: "topicTitle").value as! String))
                            topic.setPosition(p: i)
                            topic.setReplies(r: specificThreadPath.childSnapshot(forPath: "replies").value as! Int)
                            topic.setParent(pa: specificThreadPath.childSnapshot(forPath: "parent").value as! String)
                            topic.setHostUID(uid: specificThreadPath.childSnapshot(forPath: "UID").value as! String)
                             topic.setTimeStamp(t: specificThreadPath.childSnapshot(forPath: "timeStamp").value as! Int)
                               
                                if(specificThreadPath.childSnapshot(forPath: "messages").exists()){
                                    //print("message exists")
                                topic.setMessages(me: specificThreadPath.childSnapshot(forPath: "messages").value as! [Message])
                                }
                                print("upvoters is " + String(locUpvoters.count))
                                topic.setUpvoters(u: locUpvoters)
                                locUpvoters.removeAll()
                               // topic.setUpvotes(up: topic.getUpvoters().count)
                            self.topics.append(topic)
                            topicsFound = topicsFound + 1
                            }//5
                        }//4
                        else if(self.firstOpenSpotInTopics == -99){
                                self.defaults.set(i, forKey:"firstOpenSpotInTopics" )
                                self.firstOpenSpotInTopics = self.defaults.integer(forKey: "firstOpenSpotInTopics")
                            self.topicPosition = self.firstOpenSpotInTopics
                            }
                        else {
                            self.firstOpenSpotInTopics = self.defaults.integer(forKey: "firstOpenSpotInTopics")
                            self.topicPosition = self.firstOpenSpotInTopics

                        }
                        
                        
                        
                    }//3
                  
                    


                   }//2
            
            }//1
            self.handleLoadingSettings(snapshot: snapshot)
            self.localTableView.reloadData()
            SwiftSpinner.hide()

        })

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "local_cell") as! LocalTableViewCell
        cell.message.text = self.topics[indexPath.row].getTopicTitle()
        cell.replies.text = String(self.topics[indexPath.row].getMessages().count) + " replies"
        cell.upvote.text = String(self.topics[indexPath.row].getUpvoters().count)
        print("Upvotes  " + String(self.topics[indexPath.row].getUpvoters().count))
        cell.elapsedTime.text = "".getElapsedTime(userTS: Int(self.topics[indexPath.row].getTimeStamp()))
        var topicPos = indexPath.row
        print("messages count "+String(self.topics[topicPos].getMessages().count))
        cell.yourobj = {
            //print("poop")
            //If the user is not in the threads anon
            

            //print(String(topicPos) + "upvotes")
            var temp = self.topics[indexPath.row].getUpvoters()
            print(self.topics[indexPath.row].getUpvoters())
            print(" You hit topic # " + String(topicPos))
            if(temp.count == 0 || !temp.contains("".getUID())){
                temp.append("".getUID())
            self.threadRef.child("Threads").child(self.threadCode).child("topics").child(String(self.topics[indexPath.row].getPostion())).updateChildValues(["upvoters":temp])
                print("adding child")
            }
            else{
                print("user inside upvoters")
            }
        }
        //print("wired cell as "+cell.elapsedTime.text!)
        return cell
    }
    
    func handleLoadingSettings(snapshot :DataSnapshot){
        var openSpot = FirebaseCounter().MAX_SETTINGS + 1

        if(!(snapshot.childSnapshot(forPath: "Anons").childSnapshot(forPath: "".getUID()).childSnapshot(forPath: "0").exists())){
            //create a settings object and add that settings to the userPosition
            let title = self.threadTit.text!
            var settings1 = Settings()
            settings1.setName(n: title)
            settings1.setTimeStamp(ts: Date().toMillis())
            settings1.setThreadCode(t: self.threadCode)
            self.threadRef.child("Anons").child("".getUID()).child("0").updateChildValues(["threadName":settings1.getName()])
            self.threadRef.child("Anons").child("".getUID()).child("0").updateChildValues(["timeStamp":settings1.getTimeStamp()])
            self.threadRef.child("Anons").child("".getUID()).child("0").updateChildValues(["threadCode":settings1.getThreadCode()])
            print("hm")
        }
        else{
            var isSettingsFound = false
            var settingsFound = 0
            var settingsTotal = snapshot.childSnapshot(forPath: "Anons").childSnapshot(forPath: "".getUID()).childrenCount
            var settingsPath = snapshot.childSnapshot(forPath: "Anons").childSnapshot(forPath: "".getUID())
            for i in 1 ... FirebaseCounter().MAX_SETTINGS {
                if(settingsPath.childSnapshot(forPath: String(i)).exists()){
                    var threadCodeInner = settingsPath.childSnapshot(forPath: String(i)).childSnapshot(forPath: "threadCode") as! String
                    if(threadCodeInner == self.threadCode){
                        isSettingsFound = true
                    }
                    else if(i < openSpot && Int(settingsTotal) < settingsFound){
                        openSpot = i
                        print("i is less than openSpot")
                    }
                    settingsFound = settingsFound + 1
                }
            }
            if(!isSettingsFound && Int(settingsTotal) < settingsFound){
                self.threadRef.child("Anons").child("".getUID()).child(String(openSpot)).updateChildValues(["threadName":self.threadTit.text])
                self.threadRef.child("Anons").child("".getUID()).child(String(openSpot)).updateChildValues(["threadCode":self.threadCode])
                self.threadRef.child("Anons").child("".getUID()).child(String(openSpot)).updateChildValues(["timeStamp":Date().toMillis()])
                
            }
        }

    }
    
    
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        positionHit = self.topics[indexPath.row].getPostion()
        topicSelectedInList = indexPath.row
        
        DispatchQueue.main.async(execute: {
            self.performSegue(withIdentifier: "show_post", sender: indexPath)
            print("hit")
        })

        
        
    }
    
   
    
     //MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "show_post"){
            let vc = segue.destination as! PostViewController
            let topic = self.topics[topicSelectedInList]
            vc.topicPosition = positionHit
            vc.threadt = threadTit.text!///
            vc.msg = topic.getTopicTitle()
            vc.up = String(topic.getUpvoters().count)
            vc.reps = String(topic.getReplies())
            vc.time = String(topic.getTimeStamp())
            //self.dismiss(animated: true, completion: nil)
            threadRef.removeAllObservers()
        }
    }
    
    
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    

    

    

}
extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
}
}
