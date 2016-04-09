//
//  FreeDiskSpaceLocator.swift
//  DiskStatus
//
//  Created by Bjørn Sørensen on 05/04/16.
//  Copyright © 2016 Bjørn Sørensen. All rights reserved.
//

import Foundation

class FreeDiskSpaceLocator : DataLocatorStrategy {
    
    func getData() -> Double {
        let fileManager = NSFileManager.defaultManager()
        let value: Double
        do {
            let attr = try fileManager.attributesOfFileSystemForPath(NSHomeDirectory())
        
            value = attr[NSFileSystemFreeSize] as! Double
        } catch {
            value = 0
        }
        
        return value
    }
}
