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
    var name = ""
    var anons = [String]()
    var posts = [Post]()
    
    init(){
        
    }
    
    func setThreadTitle(t :String){
        threadTitle = t
    }
    
    func setName(n :String){
        name = n
    }
    
    func setAnons(a :[String]) {
        anons = a
    }
    
    func setPosts(p :[Post]) {
        posts = p
    }
    
    func getThreadTitle() -> String {
        return threadTitle
    }
    
    func getName() -> String {
        return name
    }
    
    func getAnons() -> [String] {
        return anons
    }
    
    func getPosts() -> [Post] {
        return posts
    }
    
    
    
    
}
