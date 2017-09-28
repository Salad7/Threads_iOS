//
//  Settings.swift
//  Threads
//
//  Created by cci-loaner on 9/8/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import Foundation

class Settings {
    var name = ""
    var timeStamp = Int()
    var threadCode = ""
    
    init(){
        
    }
    
    func setName(n :String){
        name = n
    }
    
    func setTimeStamp(ts: Int){
        timeStamp = ts
    }
    
    func setThreadCode(t :String){
        threadCode = t
    }
    
    func getName() -> String {
        return name
    }
    
    func getTimeStamp() -> Int {
        return timeStamp
    }
    
    func getThreadCode() -> String {
        return threadCode
    }
    
    
}
