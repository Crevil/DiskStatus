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
        let fileManager = FileManager.default
        let value: Double
        do {
            let attr = try fileManager.attributesOfFileSystem(forPath: NSHomeDirectory())
            
            let used = attr[FileAttributeKey.systemSize] as! Double
            let free = attr[FileAttributeKey.systemFreeSize] as! Double
            value = used - free
        } catch {
            value = 0
        }
        
        return value
    }
}
