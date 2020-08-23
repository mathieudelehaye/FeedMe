//
//  Macro.swift
//
//  Created by Mathieu Delehaye on 19/08/2020.
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

enum MacroType {
    case protein
    case carbohydrate
    case fat
    case energy
}

struct Macro {
    
    let type: MacroType
    
    private var _value: Float = 0
    
    public var value: Float {
        get {
            
            return _value
            
        }
        set {
            
            _value = Float(floor(10*newValue)/10)
            
        }
    }
    
    init(type macroType: MacroType, value macroValue: Float = 0) {
        
        type = macroType
        
        value = macroValue
        
    }
    
    public func getValueInt() -> Int {
        
        return Int(floor(_value))
        
    }
    
}
