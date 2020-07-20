//
//  Day.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 20/07/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import Foundation
import RealmSwift

class Day: Object {
    @objc dynamic var name: String = ""
    let meals = List<Meal>()
}
