//
//  UnitConverterType.swift
//  DiskStatus
//
//  Created by Bjørn Sørensen on 05/04/16.
//  Copyright © 2016 Bjørn Sørensen. All rights reserved.
//

import Foundation

protocol UnitConverterStrategy {
    func toString(value: Double) -> String
}
