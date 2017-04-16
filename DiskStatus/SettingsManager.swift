//
//  SettingsManager.swift
//  DiskStatus
//
//  Created by Bjørn Sørensen on 09/04/16.
//  Copyright © 2016 Bjørn Sørensen. All rights reserved.
//

import Cocoa
import ServiceManagement

protocol SettingsManagerProtocol {
    func getRefreshRateIndex() -> Int
    func setRefreshRateIndex(_ value: Int)
    func getRefreshRates() -> [Int]
    func getRefreshRate() -> Int
    func getStartOnBoot() -> Int
    func setStartOnBoot(_ value: Int)
    func setShownStatus(_ value: Int)
    func getShownStatus() -> Int
}

class SettingsManager: NSObject, SettingsManagerProtocol {
    let refreshRates: [Int] = [1, 5, 10, 30]
    let defaultRefreshRateIndex = 1

    let keyStartOnBoot = "startOnBoot"
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
    
    func getStartOnBoot() -> Int {
        return defaults.integer(forKey: keyStartOnBoot)
    }
    
    func setStartOnBoot(_ value: Int) {
        // Set boot configuration in system here.
        defaults.setValue(value, forKey: keyStartOnBoot)
        
        SMLoginItemSetEnabled("CaveOfCode.LauncherApplication", value == 0 ? false : true)
    }
    
    func setShownStatus(_ value: Int) {
        defaults.setValue(value, forKey: keyShownStatus)
    }
    
    func getShownStatus() -> Int {
        return defaults.integer(forKey: keyShownStatus)
    }
}
