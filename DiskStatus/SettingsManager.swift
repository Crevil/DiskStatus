//
//  SettingsManager.swift
//  DiskStatus
//
//  Created by Bjørn Sørensen on 09/04/16.
//  Copyright © 2016 Bjørn Sørensen. All rights reserved.
//

import Cocoa

protocol SettingsManagerProtocol {
    func getRefreshRateIndex() -> Int
    func setRefreshRateIndex(_ value: Int)
    func getRefreshRates() -> [Int]
    func getRefreshRate() -> Int
}

class SettingsManager: NSObject, SettingsManagerProtocol {
    let refreshRates: [Int] = [1, 5, 10, 30]
    let defaultRefreshRateIndex = 1

    let keyRefreshRateIndex = "refreshRateIndex"
    
    let defaults = UserDefaults.standard
    
    func getRefreshRateIndex() -> Int {
        let refreshRateIndex = defaults.integer(forKey: keyRefreshRateIndex)
        
        if refreshRateIndex >= refreshRates.count {
            return defaultRefreshRateIndex
        }
        
        return refreshRateIndex
    }
    
    func getRefreshRates() -> [Int] {
        return refreshRates
    }
    
    func getRefreshRate() -> Int {
        return refreshRates[getRefreshRateIndex()]
    }
    
    func setRefreshRateIndex(_ refreshRateIndex: Int) {
        defaults.setValue(refreshRateIndex, forKey: keyRefreshRateIndex)
    }
}
