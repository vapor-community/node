//
//  UtilityTests.swift
//  Node
//
//  Created by Logan Wright on 7/20/16.
//
//

import XCTest
@testable import Node

class UtilityTests: XCTestCase {
    func testBoolTrue() throws {
        let trues = ["true", "t", "yes", "y", "1", "100"]
        try trues.forEach { truth in
            XCTAssert(try Bool(truth))
        }
    }

    func testBoolFalse() throws {
        let falses = ["false", "f", "no", "n", "0", ""]
        try falses.forEach { truth in
            XCTAssert(try !Bool(truth))
        }
    }
}
