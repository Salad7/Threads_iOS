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
    var timeStamp = UInt64()
    var threadCode = ""
    
    init(){
        
    }
    
    func setName(n :String){
        name = n
    }
    
    func setTimeStamp(ts: UInt64){
        timeStamp = ts
    }
    
    func setThreadCode(t :String){
        threadCode = t
    }
    
    func getName() -> String {
        return name
    }
    
    func getTimeStamp() -> UInt64 {
        return timeStamp
    }
    
    func getThreadCode() -> String {
        return threadCode
    }
    
    
}
