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
    
    init(){
        
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
