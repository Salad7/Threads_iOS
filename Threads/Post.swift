//
//  Post.swift
//  Threads
//
//  Created by cci-loaner on 9/8/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import Foundation


class Post {
    var position = 0
    var upvotes = 0
    var messages = [Message]()
    var replies = 0
    var timeStamp = Int()
    var postTitle = ""
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
    func setMessages(m :[Message]){
        messages = m
    }
    func setReplies(r :Int){
        replies = r
    }
    func setTimeStamp(t :Int){
        timeStamp = t
    }
    func setPostTitle(p :String){
        postTitle = p
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
    
    func getMessages() -> [Message] {
        return messages
    }
    
    func getReplies() -> Int {
        return replies
    }
    
    func getTimeStamp() -> Int {
        return timeStamp
    }
    
    func getPostTitle() -> String{
        return postTitle
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
