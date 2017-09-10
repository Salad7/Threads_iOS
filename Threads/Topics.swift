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
    var upvotes = 0
    var topicTitle = ""
    var replies = 0
    var timeStamp = UInt64()
    var parent = ""
    var hostUID = ""
    var anonCode = [String:String]()
    
    
    init(){
        
    }
    
    func setPosition(p :Int){
        position = p
    }
    func setUpvotes(up :Int){
        upvotes = up
    }
    func setTopicTitle(tp :String){
        topicTitle = tp
    }
    func setReplies(r :Int){
        replies = r
    }
    func setTimeStamp(t :UInt64){
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
    
    func getUpvotes() -> Int {
        return upvotes
    }
    
    func getTopicTitle() -> String {
        return topicTitle
    }
    
    func getReplies() -> Int {
        return replies
    }
    
    func getTimeStamp() -> UInt64 {
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
