//
//  Day.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 20/07/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import Foundation
import RealmSwift

class Day: AppItem {
    let meals = List<Meal>()
       
    override func getOrder() -> Int {
        
        var order = 0;
        
        switch name {
        case "Monday":
            order = 1
        case "Tuesday":
            order = 2
        case "Wednesday":
            order = 3
        case "Thursday":
            order = 4
        case "Friday":
            order = 5
        case "Saturday":
            order = 6
        case "Sunday":
            order = 7
        case "Everyday":
            order = 8
        default:
            order = 0
        }
        
        return order;
        
    }
}
