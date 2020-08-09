//
//  AppItem.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 23/07/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import Foundation
import RealmSwift

class AppItem: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var order: Int = 0
        
    func getOrder() -> Int {
        
        fatalError("This method must be overridden")
        
    }
}
