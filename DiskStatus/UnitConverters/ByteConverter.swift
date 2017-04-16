//
//  ByteConverter.swift
//  DiskStatus
//
//  Created by Bjørn Sørensen on 05/04/16.
//  Copyright © 2016 Bjørn Sørensen. All rights reserved.
//

import Foundation

class ByteConverterStrategy: UnitConverterStrategy {
    let kB: Double = 1000
    let MB: Double = 1000000
    let GB: Double = 1000000000
    let TB: Double = 1000000000000
    
    func toString(_ size: Double) -> String {
        var returnValue: String = "Error"
                
        if (size < kB) {
            returnValue = String(format: "%.0f B", size)
        } else if(size < MB) {
            returnValue = String(format: "%.1f kB", (size / kB))
        } else if(size < GB) {
            returnValue = String(format: "%.1f MB", (size / MB))
        } else if(size < TB) {
            returnValue = String(format: "%.1f GB", (size / GB))
        } else {
            returnValue = String(format: "%.1f TB", (size / TB))
        }
        
        return returnValue
    }
}
