//
//  Common.swift
//  TripIn
//
//  Created by Rahul Tamrakar on 22/02/17.
//  Copyright © 2017 Rahul Tamrakar. All rights reserved.
//

import Foundation

var tomorrowDate: String {
    let tommorow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM yyyy"
    return dateFormatter.string(from: tommorow)
}

var todayDate: String {
    let today = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM yyyy"
    return dateFormatter.string(from: today)
}
