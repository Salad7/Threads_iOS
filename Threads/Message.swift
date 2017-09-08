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
    var anonChart = [String:String]()
    var hostUID = ""
    
    func setUpvotes(u :Int){
        upvotes = u
    }
    
    func setMsg(m :String){
        msg = m
    }
    
    func setAnonChart(a :[String:String]) {
        anonChart = a
    }

    func setHostUID(h :String){
        hostUID = h
    }
    
    func getUpvotes() -> Int {
        return upvotes
    }
    
    func getMsg() -> String {
        return msg
    }
    
    func getAnonChart() -> [String:String] {
        return anonChart
    }
    
    func getHostUID() -> String {
        return hostUID
    }
}
