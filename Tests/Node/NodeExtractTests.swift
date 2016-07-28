//
//  BasicTypes.swift
//  Genome
//
//  Created by Logan Wright on 9/19/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import XCTest
@testable import Node

struct NoNull: NodeInitializable {
    let node: Node
    init(node: Node, in context: Context) throws {
        guard node != .null else {
            throw NodeError.unableToConvert(node: node, expected: "something not null")
        }
        
        self.node = node
    }
}

class NodeExtractTests: XCTestCase {
    static let allTests = [
//        ("testInt", testInt),
//        ("testString", testString),
//        ("testStringSequenceObject", testStringSequenceObject),
//        ("testStringSequenceArray", testStringSequenceArray),
//        ("testIntSequence", testIntSequence),
//        ("testMixed", testMixed),
        ]

    func testExtractTransform() throws {
        let node = try Node(node: ["date": 250])
        let extracted = try node.extract("date", transform: Date.fromTimestamp)
        XCTAssert(extracted.timeIntervalSince1970 == 250)
    }

    func testExtractTransformThrows() throws {
        let node = EmptyNode
        do {
            _ = try node.extract("date", transform: Date.fromTimestamp)
            XCTFail("should throw error")
        } catch NodeError.unableToConvert {}
    }

    func testExtractTransformOptionalValue() throws {
        let node = try Node(node: ["date": 250])
        let extracted = try node.extract("date", transform: Date.optionalFromTimestamp)
        XCTAssert(extracted?.timeIntervalSince1970 == 250)
    }

    func testExtractTransformOptionalNil() throws {
        let node = EmptyNode
        let extracted = try node.extract("date", transform: Date.optionalFromTimestamp)
        XCTAssertNil(extracted)
    }

    func testExtractSingle() throws {
        let node = try Node(node: ["nest": [ "ed": ["hello": "world", "pi": 3.14159]]])
        let extracted = try node.extract("nest", "ed", "hello") as NoNull
        XCTAssert(extracted.node.string == "world")
    }

    func testExtractSingleThrows() throws {
        let node = EmptyNode
        do {
            _ = try node.extract("nest", "ed", "hello") as NoNull
            XCTFail("should throw node error unable to convert")
        } catch NodeError.unableToConvert {}
    }

    func testExtractArray() throws {
        let node = try Node(node: ["nest": [ "ed": ["array": [1, 2, 3, 4]]]])
        let extracted = try node.extract("nest", "ed", "array") as [NoNull]
        let numbers = extracted.flatMap { $0.node.int }
        XCTAssert(numbers == [1,2,3,4])
    }

    func testExtractArrayThrows() throws {
        let node = EmptyNode
        do {
            _ = try node.extract("nest", "ed", "array") as [NoNull]
            XCTFail("should throw node error unable to convert")
        } catch NodeError.unableToConvert {}
    }
}

extension Date {
    static func fromTimestamp(_ timestamp: Int) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(timestamp))
    }

    static func optionalFromTimestamp(_ timestamp: Int?) -> Date? {
        guard let stamp = timestamp else { return nil }
        return fromTimestamp(stamp)
    }
}
