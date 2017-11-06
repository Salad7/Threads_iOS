//
//  Contact.swift
//  Threads
//
//  Created by cci-loaner on 11/6/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import Foundation
import Contacts

class Contact{
    var contactName :String
    var contactPhoneNumber :String
    var contactInitial :String
    var isSend :Bool
    
    init(){
        contactName = ""
        contactPhoneNumber = ""
        contactInitial = "";
        isSend = false;
    }
    func setName(n :String){
        contactName = n
    }
    func setPhone(p :String){
        contactPhoneNumber = p
    }
    func setInitial(i :String){
        contactInitial = i
    }
    func isSend(issend :Bool){
        isSend = issend
    }
    
    func getName() -> String {
        return contactName
    }
    func getPhone() -> String {
        return contactPhoneNumber
    }
    func getInitial() -> String {
        return contactInitial
    }
    func getSend() -> Bool {
        return isSend;
    }
    
    
    
}
