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
    func setShownStatus(_ value: DataLocatorType)
    func getShownStatus() -> DataLocatorType
}

class SettingsManager: NSObject, SettingsManagerProtocol {
    let refreshRates: [Int] = [1, 5, 10, 30]
    let defaultRefreshRateIndex = 1

    let keyRefreshRateIndex = "refreshRateIndex"
    let keyShownStatus = "shownStatus"
    
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
    
    
    func setShownStatus(_ value: DataLocatorType) {
        defaults.setValue(value.rawValue, forKey: keyShownStatus)
    }
    
    func getShownStatus() -> DataLocatorType {
        let defaultStatus = DataLocatorType.freeDiskSpace
        
        let rawShownStatus = defaults.string(forKey: keyShownStatus)
        if (rawShownStatus == nil) {
            setShownStatus(defaultStatus)
            return defaultStatus
        }
        
        if let dataLocator = DataLocatorType(rawValue: rawShownStatus!) {
            return dataLocator
        } else {
            setShownStatus(defaultStatus)
            return defaultStatus
        }
    }
}
