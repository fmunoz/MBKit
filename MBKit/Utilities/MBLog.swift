//
//  MBLog.swift
//  MBKit
//
//  Created by Franklin Munoz on 2/15/18.
//  Copyright © 2018 Magic Box Software Solutions LLC. All rights reserved.
//

import Foundation

public enum MBLogLevel:Int {
    case debug = 0
    case verbose = 1
}

public final class MBLog {
    private init() {
    }
    
    var level = MBLogLevel.debug
    
    public static var shared:MBLog = {
        return MBLog()
    }()
    
    public func print(message: String, level: MBLogLevel = .debug) {
        if self.level.rawValue >= level.rawValue {
            Swift.print(message)
        }
    }
}
