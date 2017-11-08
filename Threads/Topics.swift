//
//  Topics.swift
//  Threads
//
//  Created by cci-loaner on 9/9/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import Foundation
class Topics {
    var position = 0
    var topicTitle = ""
    var replies = 0
    var timeStamp = Int()
    var parent = ""
    var hostUID = ""
    var anonCode = [String:String]()
    var messages = [Message]()
    var upvoters = [String]()
    var notifyList = [String]()
    
    func setUpvoters(u :[String]){
        upvoters = u
    }
    
    func setNotifyList(n :[String]){
        notifyList = n
    }
    
    func getNotifyList() -> [String]{
        
        return notifyList
    }
    
    func getUpvoters() -> [String]{
        return upvoters
    }
    
    
    init(){
        
    }
    
    func setPosition(p :Int){
        position = p
    }
    func setMessages(me :[Message]){
     messages = me
    }
    func getMessages() -> [Message] {
        return messages
    }
    func setTopicTitle(tp :String){
        topicTitle = tp
    }
    func setReplies(r :Int){
        replies = r
    }
    func setTimeStamp(t :Int){
        timeStamp = t
    }
    func setParent(pa :String){
        parent = pa
    }
    func setHostUID(uid :String){
        hostUID = uid
    }
    func setAnonCode(a :[String:String]){
        anonCode = a
    }
    
    func getPostion() -> Int {
        return position
    }
    
    func getTopicTitle() -> String {
        return topicTitle
    }
    
    func getReplies() -> Int {
        return replies
    }
    
    func getTimeStamp() -> Int {
        return timeStamp
    }
    
   
    
    func getParent() -> String {
        return parent
    }
    
    func getHostUID() -> String {
        return hostUID
    }
    
    func getAnonCode() -> [String:String]{
        return anonCode
    }
}
