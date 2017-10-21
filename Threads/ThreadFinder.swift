//
//  ThreadFinder.swift
//  Threads
//
//  Created by cci-loaner on 9/27/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import Foundation
class ThreadFinder{
    
    
    func runSimulation(laa :Double, loo :Double) -> [LatLng]{
    var ll = [LatLng]()
        var la = laa
        var lo = loo
        var reset = la
        for lonPos in 0 ... 100 {
            lo = lo.roundToPlaces(places: 6)+0.000001
            for latPos in 0 ... 100 {
                la = la.roundToPlaces(places: 6)+0.000001
                ll.append(LatLng(la: la, lo: lo))
            }
            la = reset
        }
        return ll
        
    }
    func mnp(){
        
    }
    
}

extension Double {
    /// Rounds the double to decimal places value
     func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }
}
