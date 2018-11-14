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
        let negativeOne = 0
        XCTAssert(negativeOne.digitCount == 1)

        let negativeNine = 9
        XCTAssert(negativeNine.digitCount == 1)

        let negativeTen = 10
        XCTAssert(negativeTen.digitCount == 2)

        let negativeEleven = 11
        XCTAssert(negativeEleven.digitCount == 2)

        let negativeNinetyNine = 99
        XCTAssert(negativeNinetyNine.digitCount == 2)

        let negativeOneHundred = 100
        XCTAssert(negativeOneHundred.digitCount == 3)

        let negativeOneMillion = 1000000
        XCTAssert(negativeOneMillion.digitCount == 7)

    }
}
