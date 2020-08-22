//
//  Meal.swift
//
//  Created by Mathieu Delehaye on 20/07/2020.
//
//  FeedMe: An app to track athele fitness diet, fully written in Swift 5 for iOS 13 or later.
//
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//
//
//  This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
//  FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
//
//  You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.

import Foundation
import RealmSwift

class Meal: AppItem {
    
    var parentCategory = LinkingObjects(fromType: Day.self, property: "meals")
    
    let aliments = List<Aliment>()
        
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
