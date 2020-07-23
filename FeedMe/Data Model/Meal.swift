//
//  Meal.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 20/07/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import Foundation
import RealmSwift

class Meal: Object {
//    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Day.self, property: "meals")
}
