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
    var timeStamp = UInt64()
    var position = 0
    var anonCode = [String:String]()
    //var anonChart = [String:String]()
    var hostUID = ""
    
    func setUpvotes(u :Int){
        upvotes = u
    }
    
    func setAnonCode(a :[String:String]){
        anonCode = a
    }
    
    func getAnonCode() -> [String:String] {
        return anonCode
    }
    
    func setPosition(p :Int){
        position = p
    }
    
    func setMsg(m :String){
        msg = m
    }
    func setReplies(r :Int){
        replies = r
    }
    func setTimeStamp(t :UInt64){
        timeStamp = t
    }
    
//    func setAnonChart(a :[String:String]) {
//        anonChart = a
//    }

    func setHostUID(h :String){
        hostUID = h
    }
    
    func getPosition() -> Int{
        return position
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
    
    func getTimeStamp() -> UInt64 {
        return timeStamp
    }
}
