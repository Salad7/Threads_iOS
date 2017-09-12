//
//  CreateThreadViewController.swift
//  Threads
//
//  Created by cci-loaner on 9/8/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import UIKit
import Firebase

class CreateThreadViewController: UIViewController {
    @IBOutlet weak var view_ui: UIView!
    
    @IBAction func submitBtn(_ sender: UIButton) {
        if((threadNameField.text?.characters.count)! > 0){
            var t = Thread()
            var u = [String]()
            u.append("".getUID())
            t.setAnons(a:u)
            t.setThreadTitle(t: (threadNameField.text)!)
            t.setTopics(tp: [createFirstTopic()])
            t.setTimeStamp(ts: Date().toMillis())
            let topic = t.getTopics()[0]
            //Create thread
            threadRef.child("Threads").child(threadCode).updateChildValues(["threadTitle" :t.getThreadTitle()])
            threadRef.child("Threads").child(threadCode).updateChildValues(["timeStamp" :t.getTimeStamp()])
            threadRef.child("Threads").child(self.threadCode).child("topics").child("0").updateChildValues(["upvoters" :topic.getUpvoters()])

            self.threadRef.child("Threads").child(self.threadCode).child("topics").child("0").updateChildValues(["parent":topic.getParent()])
            self.threadRef.child("Threads").child(self.threadCode).child("topics").child("0").updateChildValues(["UID":topic.getHostUID()])
            self.threadRef.child("Threads").child(self.threadCode).child("topics").child("0").updateChildValues(["position":topic.getPostion()])
            self.threadRef.child("Threads").child(self.threadCode).child("topics").child("0").updateChildValues(["replies":topic.getReplies()])
            self.threadRef.child("Threads").child(self.threadCode).child("topics").child("0").updateChildValues(["upvotes":topic.getUpvotes()])
            self.threadRef.child("Threads").child(self.threadCode).child("topics").child("0").updateChildValues(["anonCode":topic.getAnonCode()])
            self.threadRef.child("Threads").child(self.threadCode).child("topics").child("0").updateChildValues(["topicTitle":topic.getTopicTitle()])
            self.threadRef.child("Threads").child(self.threadCode).child("topics").child("0").updateChildValues(["timeStamp":topic.getTimeStamp()])
            performSegue(withIdentifier: "show_local", sender: nil)
        }
    }
    @IBOutlet weak var threadNameField: UITextField!
    let defaults = UserDefaults.standard
    var threadCode = ""
    var threadRef: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        threadRef = Database.database().reference()
        threadCode = defaults.string(forKey: "threadCode")!
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createFirstTopic() -> Topics{
        var topic = Topics.init()
        topic.setParent(pa: self.threadCode)
        topic.setReplies(r: 0)
        topic.setUpvotes(up: 50)
        topic.setPosition(p: 0)
        topic.setTopicTitle(tp: "Hello World")
        let u = ""
        topic.setAnonCode(a: [u.getUID():"red"])
        topic.setTimeStamp(t: Date().toMillis())
        topic.setHostUID(uid: u.getUID())
        topic.setUpvoters(u: [String]())
        return topic
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
