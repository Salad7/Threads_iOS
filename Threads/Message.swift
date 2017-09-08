//
//  Message.swift
//  Threads
//
//  Created by cci-loaner on 9/8/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import Foundation

class Message{
    var upvotes = 0
    var msg = ""
    var replies = 0
    var timeStamp = Date()
    //var anonChart = [String:String]()
    var hostUID = ""
    
    func setUpvotes(u :Int){
        upvotes = u
    }
    
    func setMsg(m :String){
        msg = m
    }
    func setReplies(r :Int){
        replies = r
    }
    func setTimeStamp(t :Date){
        timeStamp = t
    }
    
//    func setAnonChart(a :[String:String]) {
//        anonChart = a
//    }

    func setHostUID(h :String){
        hostUID = h
    }
    
    func getUpvotes() -> Int {
        return upvotes
    }
    
    func getMsg() -> String {
        return msg
    }
    
//    func getAnonChart() -> [String:String] {
//        return anonChart
//    }
    
    func getHostUID() -> String {
        return hostUID
    }
    func getReplies() -> Int {
        return replies
    }
    
    func getTimeStamp() -> Date {
        return timeStamp
    }
}
