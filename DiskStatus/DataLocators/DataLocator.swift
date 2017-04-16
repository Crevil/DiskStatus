//
//  DataLocator.swift
//  DiskStatus
//
//  Created by Bjørn Sørensen on 05/04/16.
//  Copyright © 2016 Bjørn Sørensen. All rights reserved.
//

import Foundation

class DataLocator : DataLocatorStrategy {
    var strategy: DataLocatorStrategy?
    
    func getData() -> Double {
        return (strategy?.getData())!
    }
    
    init(strategy: DataLocatorStrategy) {
        self.strategy = strategy
    }
    
    func setStrategy(_ strategy: DataLocatorStrategy) {
        self.strategy = strategy
    }
}
