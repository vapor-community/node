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
    func testBoolTrue() {
        let trues = ["true", "t", "yes", "y", "1", "100"]
        trues.forEach { truth in
            XCTAssert(Bool(truth))
        }
    }

    func testBoolFalse() {
        let falses = ["false", "f", "no", "n", "0", ""]
        falses.forEach { truth in
            XCTAssert(!Bool(truth))
        }
    }
}
