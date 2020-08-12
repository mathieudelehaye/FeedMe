//
//  AlimentType.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 11/08/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import Foundation
import RealmSwift

class AlimentType: AppItem {
    
    @objc dynamic var quantity: Int = 0
    
    @objc dynamic var proteinSpecific: Int = 0
    
    @objc dynamic var carbsSpecific: Int = 0
    
    @objc dynamic var fatSpecific: Int = 0
    
    @objc dynamic var energySpecific: Int = 0
    
    override func getOrder() -> Int {
                
        return 0
        
    }
}
