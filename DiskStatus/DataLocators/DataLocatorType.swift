//
//  DataLocatorType.swift
//  DiskStatus
//
//  Created by Bjørn Sørensen on 16/04/2017.
//  Copyright © 2017 Bjørn Sørensen. All rights reserved.
//

enum DataLocatorType: String {
    case freeDiskSpace
    case usedDiskSpace
    
    init() {
        self = .freeDiskSpace
    }
}
