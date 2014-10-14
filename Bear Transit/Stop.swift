//
//  Stop.swift
//  Bear Transit
//
//  Created by Daylen Yang on 10/9/14.
//  Copyright (c) 2014 Daylen Yang. All rights reserved.
//

import Foundation

class Stop : Printable {
    
    var identifier : String
    var name : String
    var lat : Double
    var lon : Double
    var distance : Double
    
    init(identifier: String, name: String, lat: Double, lon: Double, distance: Double) {
        self.identifier = identifier
        self.name = name
        self.lat = lat
        self.lon = lon
        self.distance = distance
    }
    
    func getSafeIdentifier() -> String {
        return identifier.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.allZeros, range: nil)
    }
    
    var description: String {
        get {
            return name
        }
    }
    
}