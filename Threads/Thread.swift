//
//  Thread.swift
//  Threads
//
//  Created by cci-loaner on 9/8/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import Foundation

class Thread {
    var threadTitle = ""
    var anons = [String]()
    var topics = [Topics]()
    var timeStamp = Int()
    
    
    init(){
        
    }
    
    func setTimeStamp(ts :Int){
        timeStamp = ts
    }
    
    func getTimeStamp() -> Int{
        return timeStamp
    }
    
    func setThreadTitle(t :String){
        threadTitle = t
    }
   
    
   
    func setAnons(a :[String]) {
        anons = a
    }
    
    func setTopics(tp :[Topics]) {
        topics = tp
    }
    
    func getThreadTitle() -> String {
        return threadTitle
    }
    
 
    
    func getAnons() -> [String] {
        return anons
    }
    
    func getTopics() -> [Topics] {
        return topics
    }
    
    
    
    
}
