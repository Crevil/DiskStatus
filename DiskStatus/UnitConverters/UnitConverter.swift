//
//  UnitConverter.swift
//  DiskStatus
//
//  Created by Bjørn Sørensen on 05/04/16.
//  Copyright © 2016 Bjørn Sørensen. All rights reserved.
//

import Foundation

class UnitConverter {
    let strategy: UnitConverterStrategy
    
    func toString(_ value: Double) -> String {
        return strategy.toString(value)
    }
    
    init(strategy: UnitConverterStrategy) {
        self.strategy = strategy
    }
}
