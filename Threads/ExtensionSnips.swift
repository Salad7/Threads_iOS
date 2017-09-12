//
//  ExtensionSnips.swift
//  Threads
//
//  Created by cci-loaner on 9/9/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import Foundation
import UIKit

class ExtensioncLIPS{
    
}
extension Date {
    func toMillis() -> UInt64! {
        return UInt64(self.timeIntervalSince1970 * 1000)
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
