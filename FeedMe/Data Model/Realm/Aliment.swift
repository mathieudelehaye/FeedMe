//
//  Aliment.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 10/08/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import Foundation
import RealmSwift

class Aliment: AppItem {
    
    var parentCategory = LinkingObjects(fromType: Meal.self, property: "aliments")
        
    @objc dynamic var type: AlimentType? = nil
    
    override func getOrder() -> Int {
                
        return 0 
        
    }
}
