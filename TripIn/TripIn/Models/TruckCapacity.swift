//
//  TruckCapacity.swift
//  TripIn
//
//  Created by Rahul Tamrakar on 22/02/17.
//  Copyright © 2017 Rahul Tamrakar. All rights reserved.
//

import Foundation

class TruckCapacity {

    var truckCapacity   : String?
    var truckLengths    : [String]?
    var truckAvailable  : Int?
    var truckRent       : Int?
    
    init(truckCapacity:String, truckLengths:[String], truckAvailable:Int=0, truckRent:Int=0) {
        self.truckCapacity  = truckCapacity
        self.truckLengths   = truckLengths
        self.truckAvailable = truckAvailable
        self.truckRent      = truckRent
    }
    
    func updateAvailability() {
        self.truckAvailable = self.truckAvailable! - 1
    }
    
}
