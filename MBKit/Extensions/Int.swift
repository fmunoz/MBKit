//
//  Int.swift
//  MBKit
//
//  Created by Franklin Munoz on 2/7/18.
//  Copyright © 2018 Magic Box Software Solutions LLC. All rights reserved.
//

import Foundation

extension Int {
    var digitCount:Int {
        var x = abs(self);
        var count = 1;
        while x >= 10 {
            count += 1
            x /= 10
        }
        return count
    }
}
