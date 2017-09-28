//
//  ExtensionSnips.swift
//  Threads
//
//  Created by cci-loaner on 9/9/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import Foundation
import UIKit

class ExtensionSnips{
    
}
extension Date {
    func toMillis() -> Int! {
        return Int(self.timeIntervalSince1970)
    }
}
extension String {
        func getUID() -> String {
            return UIDevice.current.identifierForVendor!.uuidString
        }
    func convertMillisToTime(ms: String){
        //let date = Date(timeIntervalSince1970: ms)
    }
    }

extension Double {
    func truncate(places: Int) -> Double {
        return Double(floor(pow(10.0, Double(places))*self)/pow(10.0, Double(places)))
    }
}

extension Date {
    var ticks: Int {
        return Int(self.timeIntervalSince1970)
    }
}


    
    extension String {
        func getElapsedTime(userTS :Int) -> String{
            let date = Date()
            let calendar = Calendar.current
            var secondsCap = 60
            var minutesCap = 3600
            var hoursCap = 216000
            var daysCap = 51840000
            let month = calendar.component(.month, from: date)
            var monthsCamp = getLastDayInCalender(month: Int(8))
            var timestamp = Date().ticks
            var difference = timestamp - userTS
            var getSeconds = difference
            //Limit seconds in a minute
            if(getSeconds < 60){
                if(getSeconds == 1){
                    return String(getSeconds)+" second ago"
                }
                return String(getSeconds)+" seconds ago"
            }
                //Limit seconds in an hour
            else if (getSeconds > 60 && getSeconds < 3600){
                if(getSeconds/60 == 1){
                    return String(getSeconds/60)+" minute ago"
                    
                }
                return String(getSeconds/60)+" minutes ago"
                
            }
                //Limit seconds in a day
            else if(getSeconds > 3600 && getSeconds < 86400){
                if(getSeconds/3600 == 1){
                    return String(getSeconds/3600)+" hour ago"
                    
                }
                return String(getSeconds/3600)+" hours ago"
                
            }
                //limit seconds in a week
            else if(getSeconds > 86400 && getSeconds < 604800){
                if(getSeconds/86400 == 1){
                    return String(getSeconds/86400)+" day ago"
                }
                return String(getSeconds/86400)+" days ago"
            }
                //limit seconds in a month
            else if(getSeconds > 604800 && getSeconds < monthsCamp*864000){
                if(getSeconds/604800 == 1){
                    return String(1)+" week ago"
                    
                }else{
                    return String(getSeconds/604800)+" weeks ago"
                    
                }
            }
                //limit seconds in a year
            else if(getSeconds > monthsCamp*864000 && getSeconds < monthsCamp*864000*12){
                if(getSeconds/(monthsCamp*864000) == 1){
                    return String(getSeconds/(monthsCamp*864000))+" month ago"
                }
                return String(getSeconds/(monthsCamp*864000))+" months ago"
            }
                
            else{
                return " over a year ago"
            }
            
        }
        
        func getLastDayInCalender(month :Int) -> Int{
            if(month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12){
                return 31
            }
            if(month == 2){
                return 28
            }
            return 30
        }
    }


