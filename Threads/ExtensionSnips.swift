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
    }
