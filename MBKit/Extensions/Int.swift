//
//  Int.swift
//  MBKit
//
//  Created by Franklin Munoz on 2/7/18.
//  Copyright © 2018 Magic Box Software Solutions LLC. All rights reserved.
//

import Foundation

public extension Int {
    var digitCount: Int {
        var workingValue = abs(self)
        var count = 1
        while workingValue >= 10 {
            count += 1
            workingValue /= 10
        }
        return count
    }
}
