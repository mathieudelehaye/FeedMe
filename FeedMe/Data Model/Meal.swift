//
//  Meal.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 20/07/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import Foundation
import RealmSwift

class Meal: AppItem {
//    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Day.self, property: "meals")
        
    override func getOrder() -> Int {
        
        var order = 0;
        
        switch name {
        case "Breakfast":
            order = 1
        case "Lunch":
            order = 2
        case "Dinner":
            order = 3
        case "Snack 1":
            order = 4
        case "Snack 2":
            order = 5
        case "Snack 3":
            order = 6
        default:
            order = 0
        }
        
        return order
        
    }
}
