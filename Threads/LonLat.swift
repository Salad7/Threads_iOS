//
//  LonLat.swift
//  Threads
//
//  Created by cci-loaner on 9/8/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import Foundation
class LonLat {
var lat = 0.00000
var lon = 0.00000


func setLonLat(la :Double, lo :Double){
    lat = la
    lon = lo
}

func getLat() -> Double{
    return lat
}
func getLon() -> Double{
    return lon
}

}
