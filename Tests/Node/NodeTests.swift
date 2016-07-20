//
//  NodeEquatableTests.swift
//  Node
//
//  Created by Logan Wright on 7/20/16.
//
//

import XCTest
@testable import Node

class NodeEquatableTests: XCTestCase {

    func testInits() {
        // these are mostly here to ensure compilation errors don't occur
        XCTAssert(Node(true) == .bool(true))
        XCTAssert(Node("hi") == .string("hi"))
        XCTAssert(Node(1) == .number(1))
        XCTAssert(Node(3.14) == .number(3.14))

        let uint = UInt(42)
        XCTAssert(Node(uint) == .number(Node.Number(uint)))

        let number = Node.Number(2345)
        XCTAssert(Node(number) == .number(number))

        let array = [Node(1), Node(2), Node(3)]
        XCTAssert(Node(array) == .array([1,2,3]))

        let object = ["key": Node("value")]
        XCTAssert(Node(object) == .object(object))

        XCTAssert(Node(bytes: [1,2,3,4]) == .bytes([1,2,3,4]))
    }

    func testLiterals() {
        XCTAssert(Node.null == nil)
        XCTAssert(Node.bool(false) == false)
        XCTAssert(Node.number(1) == 1)
        XCTAssert(Node.number(42.3) == 42.3)

        XCTAssert(Node.string("test") == "test")
        let unicode = Node(unicodeScalarLiteral: "test")
        XCTAssert(Node.string("test") == unicode)
        let grapheme = Node(extendedGraphemeClusterLiteral: "test")
        XCTAssert(Node.string("test") == grapheme)

        XCTAssert(Node.array([1,2,3]) == [1,2,3])
        XCTAssert(Node.object(["key": "value"]) == ["key": "value"])
    }

    func testEquatable() throws {
        let truthyPairs: [(Node, Node)] = [
            (nil, nil),
            (1, 1.0),
            (true, true),
            (false, false),
            ("hello", "hello"),
            ([1,2,3], [1,2,3]),
            (["key": "value"], ["key": "value"])
        ]

        truthyPairs.forEach { lhs, rhs in XCTAssert(lhs == rhs, "\(lhs) should equal \(rhs)") }

        let falsyPairs: [(Node, Node)] = [
            (nil, 42),
            (1, "hello"),
            (true, ["key": "value"]),
            ([1,2,3], false),
            ("hello", "goodbye"),
            ([1,2,3], [1,2,3,4]),
            (["key": "value"], ["array", "of", "strings"])
        ]

        falsyPairs.forEach { lhs, rhs in XCTAssert(lhs != rhs, "\(lhs) should equal \(rhs)") }
    }

}
