//
//  Int.swift
//  MBKitTests
//
//  Created by Franklin Munoz on 2/7/18.
//  Copyright © 2018 Magic Box Software Solutions LLC. All rights reserved.
//

import XCTest
@testable import MBKit

class IntTests: XCTestCase {
    
    func testDigitCount() {
        
        //Zero
        let zero = 0
        XCTAssert(zero.digitCount == 1)
        
        //Positives
        let one = 0
        XCTAssert(one.digitCount == 1)
        
        let nine = 9
        XCTAssert(nine.digitCount == 1)
        
        let ten = 10
        XCTAssert(ten.digitCount == 2)
        
        let eleven = 11
        XCTAssert(eleven.digitCount == 2)
        
        let ninetyNine = 99
        XCTAssert(ninetyNine.digitCount == 2)
        
        let oneHundred = 100
        XCTAssert(oneHundred.digitCount == 3)
        
        let oneMillion = 1000000
        XCTAssert(oneMillion.digitCount == 7)
        
        //Negatives
        let n_one = 0
        XCTAssert(n_one.digitCount == 1)
        
        let n_nine = 9
        XCTAssert(n_nine.digitCount == 1)
        
        let n_ten = 10
        XCTAssert(n_ten.digitCount == 2)
        
        let n_eleven = 11
        XCTAssert(n_eleven.digitCount == 2)
        
        let n_ninetyNine = 99
        XCTAssert(n_ninetyNine.digitCount == 2)
        
        let n_oneHundred = 100
        XCTAssert(n_oneHundred.digitCount == 3)
        
        let n_oneMillion = 1000000
        XCTAssert(n_oneMillion.digitCount == 7)
        
    }
}
