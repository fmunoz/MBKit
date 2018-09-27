//
//  MBSimpleStore.swift
//  MBKitTests
//
//  Created by Franklin Munoz on 9/26/18.
//  Copyright © 2018 Magic Box Software Solutions LLC. All rights reserved.
//

import XCTest

@testable import MBKit

class MBSimpleStoreTests: XCTestCase {

    var store:MBSimpleStore!
    override func setUp() {
        store = MBSimpleStore(name: "tests")
    }

    override func tearDown() {
        do {
                try FileManager.default.removeItem(at: store.fileURL)
        } catch let error as NSError {
            print("Failed to delete test file for MBSimpleStoreTests: \(error)")
        }
    }

    func test() {
        let names = NSArray( array: [ "John", "Peter", "James", "Andrew" ] )
        
        if !store.save(names, key: "names") {
            XCTFail("failed to save names to MBSimpleStore")
        }
        
        let savedNames = store.fetchObject(for: "names") as! NSArray
        XCTAssertTrue(savedNames.isEqual(names))
        
        let numbers = NSArray(array: [1,2,3,4,5])
        if !store.save(numbers, key: "numbers") {
            XCTFail("Failed to save numbers to MBSimpleStore")
        }
        
        let savedNumbers = store.fetchObject(for: "numbers") as! NSArray
        XCTAssertTrue(savedNumbers.isEqual(numbers))
        
        XCTAssertFalse(savedNumbers.isEqual(names))
    }
}
