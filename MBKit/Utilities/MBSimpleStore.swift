//
//  SimpleStore.swift
//  Math Minute
//
//  Created by Franklin Munoz on 12/20/17.
//  Copyright © 2017 Magic Box Software Solutions LLC. All rights reserved.
//

import Foundation

open class MBSimpleStore {
    let name:String
    
    public init(name:String) {
        self.name = name
    }
    
    public lazy var fileURL:URL! = {
        var result : URL!
        do {
            let manager = FileManager.default
            let dirURL = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            result = dirURL.appendingPathComponent(name)
        } catch let error as NSError {
            MBLog.shared.print("fileURL: Failed to get file URL: \(error)")
        }
        
        return result
    }()
    
    
    open func save(_ object: NSCoding, key:String) -> Bool {
        var result = false;
        
        let archiver = NSKeyedArchiver.init(requiringSecureCoding: false)
        archiver.encode(object, forKey: key)
        archiver.finishEncoding()
        let data = archiver.encodedData
        do {
            try data.write(to: fileURL ,options: [NSData.WritingOptions.atomic])
            result = true
        } catch let error as NSError {
            MBLog.shared.print("MBSimpleStore.save: Failed to save data to disk: \(error)")
            return result;
        }
        
        return result
    }
    
    open func fetchObject(for key:String)->Any? {
        var result : Any?

        guard let data = try? Data.init(contentsOf: fileURL) else {
            MBLog.shared.print("MBSimpleStore.fetchObject: Failed to load data from disk")
            return result
        }
        
        guard let unarchiver = try? NSKeyedUnarchiver(forReadingFrom: data) else {
            MBLog.shared.print("MBSimpleStore.fetchObject: Failed to crete unarchiver")
            return result
        }
        unarchiver.requiresSecureCoding = false
        do {
            result = try unarchiver.decodeTopLevelObject(forKey: key)
        } catch let error as NSError {
            MBLog.shared.print("MBSimpleStore.fetchObject: Failed to uarchive data: \(error)")
        }
        unarchiver.finishDecoding()

        return result
    }
}
