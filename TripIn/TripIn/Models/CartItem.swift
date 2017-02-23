//
//  CartItem.swift
//  TripIn
//
//  Created by Rahul Tamrakar on 22/02/17.
//  Copyright © 2017 Rahul Tamrakar. All rights reserved.
//

import Foundation

class CartItem {
    
    var truckBodyType   : String?
    var truckCapacity   : String?
    var truckLength     : String?
    var truckRent       : Int?
    
    init(truckType:String, truckCapacity:String, truckLength:String, truckRent:Int) {
        self.truckBodyType  = truckType
        self.truckCapacity  = truckCapacity
        self.truckLength    = truckLength
        self.truckRent      = truckRent
    }
}
