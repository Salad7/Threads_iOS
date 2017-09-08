//
//  Anon.swift
//  Threads
//
//  Created by cci-loaner on 9/8/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import Foundation


class Anon {
    var postCount = 0
    var threads = [Thread]()
    
    init(){
        
    }
    
    init(pC :Int, t :[Thread]){
        postCount = pC
        threads = t
    }
    
    func getPostCount() -> Int{
        return postCount
    }
    
    func getThreads() -> [Thread]{
        return threads
    }
    
    
}
