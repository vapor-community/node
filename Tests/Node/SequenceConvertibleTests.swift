//
//  SequenceConvertibleTests.swift
//  Node
//
//  Created by Logan Wright on 7/20/16.
//
//

import XCTest
import Node

private class Model: NodeInitializable {
    let node: Node
    required init(with node: Node, in context: Context) {
        self.node = node
    }
}

class SequenceConvertibleTests: XCTestCase {
    static let allTests = [
        ("testSequence", testSequence),
        ("testDictionary", testDictionary),
        ("testArrayConvert", testArrayConvert),
        ("testSetConvert", testSetConvert),
    ]

    final class Foo: NodeConvertible {
        var node: Node

        init(with node: Node, in context: Context) throws {
            self.node = node
        }

        func makeNode() throws -> Node {
            return node
        }
    }

    func testSequence() throws {
        let ints: [Int] = [1,2,3,4,5]
        let node = try ints.makeNode()
        XCTAssert(node == .array([1,2,3,4,5]))

        let representables = ints.map { $0 as NodeRepresentable }
        let node2 = try representables.makeNode()
        XCTAssert(node2 == .array([1,2,3,4,5]))

        let models = try ints.converted(to: [Model].self)
        let backInts = models.map { $0.node } .flatMap { $0.int }
        XCTAssert(backInts == ints)

        let models2 = try representables.converted(to: [Model].self)
        let backInts2 = models2.map { $0.node } .flatMap { $0.int }
        XCTAssert(backInts2 == ints)
    }

    func testDictionary() throws {
        let dict: [String: String] = [
            "key": "val",
            "hi": "world"
        ]
        let node = try dict.makeNode()
        XCTAssert(node == ["key": "val", "hi": "world"])

        let model = try dict.converted(to: Model.self)
        XCTAssert(model.node["key"]?.string == "val")
        XCTAssert(model.node["hi"]?.string == "world")
    }

    func testArrayConvert() throws {
        let ints = try [Int](with: Node.array([1,2,3,4,"5"]))
        XCTAssert(ints == [1,2,3,4,5])

        let one = try [Int](with: 1)
        XCTAssert(one == [1])

        let strings = ["1", "2", "3", "4", "5"]
        let collected = try [Int](with: strings)
        XCTAssert(collected == [1,2,3,4,5])

        let collectedMixed = try [Int](with: [1, 2, "3", "4", 5])
        XCTAssert(collectedMixed == [1,2,3,4,5])
    }

    func testSetConvert() throws {
        let ints = try Set<Int>(with: Node.array([1,2,3,4,"5"]))
        XCTAssert(ints == [1,2,3,4,5])

        let one = try Set<Int>(with: 1)
        XCTAssert(one == [1])

        let strings = ["1", "2", "3", "4", "5"]
        let collected = try Set<Int>(with: strings)
        XCTAssert(collected == [1,2,3,4,5])

        let collectedMixed = try Set<Int>(with: [1, 2, "3", "4", 5])
        XCTAssert(collectedMixed == [1,2,3,4,5])
    }

    func testRepresentableDictionary() throws {
        let node = try Node([
            "hello": 52,
            ])
        XCTAssertEqual(node, .object(["hello": 52]))

        let foo = try Foo([
            "hello": 52
        ])
        XCTAssertEqual(foo.node, .object(["hello": 52]))

        let fooWithNil = try Foo([
            "hello": nil
        ])
        XCTAssertEqual(fooWithNil.node, .object(["hello": .null]))
    }

    func testRepresentableArray() throws {
        let node = try Node([
            "hello",
        ])
        XCTAssertEqual(node, .array(["hello"]))


        let foo = try Foo([
            "hello"
        ])
        XCTAssertEqual(foo.node, .array(["hello"]))

        let fooWithNil = try Foo([
            nil
        ])
        XCTAssertEqual(fooWithNil.node, .array([.null]))

    }
}
