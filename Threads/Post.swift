//
//  Post.swift
//  Threads
//
//  Created by cci-loaner on 9/8/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import Foundation


class Post {
    var ucode = ""
    var upvotes = 0
    var messages = [Message]()
    var replies = 0
    var timeStamp = Date()
    var postTitle = ""
    var parent = ""
    
    
    init(){
        
    }
    
    func setUcode(u :String){
        ucode = u
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
    func setTimeStamp(t :Date){
        timeStamp = t
    }
    func setPostTitle(p :String){
        postTitle = p
    }
    func setParent(pa :String){
        parent = pa
    }
    
    func getUcode() -> String {
        return ucode
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
    
    func getTimeStamp() -> Date {
        return timeStamp
    }
    
    func getPostTitle() -> String{
        return postTitle
    }
    
    func getParent() -> String {
        return parent
    }
    
    
}
