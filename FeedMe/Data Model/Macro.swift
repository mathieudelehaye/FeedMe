//
//  Macro.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 19/08/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

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
    
    public func getValueInt() -> Int {
        
        return Int(floor(_value))
        
    }
    
    init(type macroType: MacroType, value macroValue: Float = 0) {
        
        type = macroType
        
        value = macroValue
        
    }
    
}
