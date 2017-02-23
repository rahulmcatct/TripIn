//
//  Truck.swift
//  TripIn
//
//  Created by Rahul Tamrakar on 21/02/17.
//  Copyright © 2017 Rahul Tamrakar. All rights reserved.
//

import Foundation

class Truck {
    
    var truckBodyType   : String?
    var truckImageName  : String?
    
    init(truckType:String, truckImageName:String) {
        self.truckBodyType  = truckType
        self.truckImageName = truckImageName
    }
}
