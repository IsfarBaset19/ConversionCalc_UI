//
//  Conversion.swift
//  HW3-Solution
//
//  Created by Isfar Baset on 3/28/20.
//  Copyright © 2020 Jonathan Engelsma. All rights reserved.
//

import Foundation

struct Conversion {
    var fromVal: Double
    var toVal: Double
    var mode: CalculatorMode
    var fromUnits: String
    var toUnits: String
    var timestamp: Date
    
    init(fromVal:Double, toVal:Double, mode:CalculatorMode, fromUnits:String, toUnits:String, timestamp:Date) {
        
        self.fromVal = fromVal
        self.toVal = toVal
        self.mode = mode
        self.fromUnits = fromUnits
        self.toUnits = toUnits
        self.timestamp = timestamp
    }
}
