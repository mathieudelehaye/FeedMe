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
}
