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
    
    @objc dynamic var proSpecific: Float = 0
    
    @objc dynamic var carSpecific: Float = 0
    
    @objc dynamic var fatSpecific: Float = 0
    
    @objc dynamic var calSpecific: Float = 0
        
    override func getOrder() -> Int {
                
        return 0
        
    }
}
