//
//  UsedDiskSpaceLocator.swift
//  DiskStatus
//
//  Created by Bjørn Sørensen on 05/04/16.
//  Copyright © 2016 Bjørn Sørensen. All rights reserved.
//

import Foundation

class UsedDiskSpaceLocator : DataLocatorStrategy {
    
    func getData() -> Double {
        let fileManager = NSFileManager.defaultManager()
        let value: Double
        do {
            let attr = try fileManager.attributesOfFileSystemForPath(NSHomeDirectory())
            
            let used = attr[NSFileSystemSize] as! Double
            let free = attr[NSFileSystemFreeSize] as! Double
            value = used - free
        } catch {
            value = 0
        }
        
        return value
    }
}
