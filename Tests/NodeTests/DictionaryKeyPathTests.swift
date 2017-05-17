//
//  DictionaryKeyPathTests.swift
//  Genome
//
//  Created by Logan Wright on 7/2/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import XCTest
import Node

class DictionaryKeyPathTests: XCTestCase {
    static let allTests = [
        ("testPaths", testPaths),
        ("testGarbage", testGarbage),
    ]
    
    func testPaths() {
        let inner = Node(["two" : .string("Found me!")])
        var test = Node([
            "one" : inner
            ])

        guard let node = test["one", "two"] else {
            XCTFail()
            return
        }

        guard let str = node.string else {
            XCTFail()
            return
        }
        XCTAssert(str == "Found me!")

        test["path", "to", "new", "value"] = .string("Hello!")
        guard let setVal = test["path", "to", "new", "value"] else {
            XCTFail()
            return
        }
        guard let setStr = setVal.string else {
            XCTFail()
            return
        }

        XCTAssert(setStr == "Hello!")
    }

    func testGarbage() throws {
        let node = try! [1, 2, "3", "4", ["hello": "world"]].converted(to: Node.self, in: nil)
        XCTAssertEqual(node[0], 1)
        XCTAssertEqual(node[1], 2)
        XCTAssertEqual(node[2], "3")
        XCTAssertEqual(node[3], "4")
        XCTAssertEqual(node[4, "hello"], "world")
    }
}
