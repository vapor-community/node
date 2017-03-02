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
        ("testGarbage", testGarbage)
    ]
    
    func testPaths() {
        let TestDictionary: Node = [
            "one" : [
                "two" : "Found me!"
            ]
        ]

        var node = TestDictionary

        let path: [String] = ["one", "two"]
        let value: String! = node[path]?.string
        XCTAssert(value == "Found me!")

        node["path", "to", "new", "value"] = "Hello!"
        let setVal = node["path", "to", "new", "value"]
        XCTAssertEqual(setVal, "Hello!")
    }

    func testGarbage() throws {
        let node = try [1, 2, "3", "4", ["hello": "world"]].converted(to: Node.self)
        XCTAssertEqual(node[0], 1)
        XCTAssertEqual(node[1], 2)
        XCTAssertEqual(node[2], "3")
        XCTAssertEqual(node[3], "4")
        XCTAssertEqual(node[4, "hello"], "world")
    }
}
