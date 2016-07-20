//
//  ConvertibleTests.swift
//  Node
//
//  Created by Logan Wright on 7/20/16.
//
//

import XCTest
import Node

class BasicConvertibleTests: XCTestCase {
    static let allTests = [
        ("testBoolInit", testBoolInit),
        ("testBoolRepresent", testBoolRepresent),
        ("testIntegerInit", testIntegerInit),
        ("testIntegerRepresent", testIntegerRepresent),
        ("testDoubleInit", testDoubleInit),
        ("testDoubleRepresent", testDoubleRepresent),

        ("testFloatInit", testFloatInit),
        ("testFloatRepresent", testFloatRepresent),
        ("testUnsignedIntegerInit", testUnsignedIntegerInit),
        ("testUnsignedIntegerRepresent", testUnsignedIntegerRepresent),
        ("testStringInit", testStringInit),
        ("testStringRepresent", testStringRepresent),
        ("testNodeConvertible", testNodeConvertible),
    ]

    func testBoolInit() throws {
        let truths: [Node] = [
            "true", "t", "yes", "y", 1, 1.0, "1"
        ]
        try truths.forEach { truth in try XCTAssert(Bool(with: truth)) }

        let falsehoods: [Node] = [
            "false", "f", "no", "n", 0, 0.0, "0"
        ]
        try falsehoods.forEach { falsehood in try XCTAssert(!Bool(with: falsehood)) }

        let fails: [Node] = [
            [1,2,3], ["key": "value"], .null
        ]
        try assert(Bool.self, fails: fails)
    }

    func testBoolRepresent() {
        let truthy = true.makeNode()
        let falsy = false.makeNode()
        XCTAssert(truthy == .bool(true))
        XCTAssert(falsy == .bool(false))
    }

    func testIntegerInit() throws {
        let string = Node("400")
        let int = Node(-42)
        let double = Node(55.6)
        let bool = Node(true)

        try XCTAssert(Int(with: string) == 400)
        try XCTAssert(Int(with: int) == -42)
        try XCTAssert(Int(with: double) == 55)
        try XCTAssert(Int(with: bool) == 1)

        let fails: [Node] = [
            [1,2,3], ["key": "value"], .null
        ]
        try assert(Int.self, fails: fails)
    }

    func testIntegerRepresent() {
        let node = 124.makeNode()
        XCTAssert(node == .number(124))
    }

    func testDoubleInit() throws {
        let string = Node("433.1029")
        let int = Node(-42)
        let double = Node(55.6)
        let bool = Node(true)

        try XCTAssert(Double(with: string) == 433.1029)
        try XCTAssert(Double(with: int) == -42.0)
        try XCTAssert(Double(with: double) == 55.6)
        try XCTAssert(Double(with: bool) == 1.0)

        let fails: [Node] = [
            [1,2,3], ["key": "value"], .null
        ]
        try assert(Double.self, fails: fails)
    }

    func testDoubleRepresent() {
        let node = 124.534.makeNode()
        XCTAssert(node == .number(124.534))
    }

    func testFloatInit() throws {
        let string = Node("433.1029")
        let int = Node(-42)
        let double = Node(55.6)
        let bool = Node(true)

        try XCTAssert(Float(with: string) == 433.1029)
        try XCTAssert(Float(with: int) == -42.0)
        try XCTAssert(Float(with: double) == 55.6)
        try XCTAssert(Float(with: bool) == 1.0)

        let fails: [Node] = [
            [1,2,3], ["key": "value"], .null
        ]
        try assert(Float.self, fails: fails)
    }

    func testFloatRepresent() {
        let float = Float(123.0)
        let node = float.makeNode()
        XCTAssert(node == .number(123.0))
    }

    func testUnsignedIntegerInit() throws {
        let string = Node("400")
        let int = Node(42)
        let double = Node(55.6)
        let bool = Node(true)

        try XCTAssert(UInt(with: string) == 400)
        try XCTAssert(UInt(with: int) == 42)
        try XCTAssert(UInt(with: double) == 55)
        try XCTAssert(UInt(with: bool) == 1)

        let fails: [Node] = [
            [1,2,3], ["key": "value"], .null
        ]
        try assert(UInt.self, fails: fails)
    }

    func testUnsignedIntegerRepresent() {
        let uint = UInt(124)
        let node = uint.makeNode()
        XCTAssert(node == .number(124))
    }

    func testStringInit() throws {
        let string = Node("hello :)")
        let int = Node(42)
        let double = Node(55.6)
        let bool = Node(true)

        try XCTAssert(String(with: string) == "hello :)")
        try XCTAssert(String(with: int) == "42")
        try XCTAssert(String(with: double) == "55.6")
        try XCTAssert(String(with: bool) == "true")

        let fails: [Node] = [
            [1,2,3], ["key": "value"], .null
        ]
        try assert(String.self, fails: fails)
    }

    func testStringRepresent() {
        let node = "hello :)".makeNode()
        XCTAssert(node == .string("hello :)"))
    }

    func testNodeConvertible() throws {
        let node = Node("hello node")
        let initted = try Node(node)
        let made = node.makeNode()
        XCTAssert(initted == made)
    }

    private func assert<N: NodeInitializable>(_ n: N.Type, fails cases: [Node]) throws {
        try cases.forEach { fail in
            do {
                _ = try N(with: fail)
            } catch Error.unableToConvert {}
        }
    }
}
