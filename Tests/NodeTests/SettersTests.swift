import Foundation
import XCTest
import Node

class SettersTests: XCTestCase {
    static let allTests = [
        ("testSetters", testSetters)
    ]

    func testSetters() throws {
        var node = Node([:])

        let singular = 1
        try node.set("singular", singular)

        let array = ["foo", "bar"]
        try node.set("array", array)

        let nestedArray = [[0], [1], [2]]
        try node.set("nestedArray", nestedArray)

        let arrayOfObjects = [["name": "a"], ["name": "b"]]
        try node.set("arrayOfObjects", arrayOfObjects)

        let dictionary = ["hello": "world"]
        try node.set("dictionary", dictionary)

        let dictionaryWithArray = ["hello": ["a", "b", "c"]]
        try node.set("dictionaryWithArray", dictionaryWithArray)

        let path = "path"
        try node.set("I.Live.Down.The.Road.At.0.Index", path)

        let dictionaryWithDictionary = [
            "person": [
                "age": 13
            ]
        ]
        try node.set("person", dictionaryWithDictionary)
        // ASSERTIONS

        try node.assert("singular", expectation: singular)

        try node.assert("array", expectation: array.makeNode())

        let na = try nestedArray.map { try $0.makeNode() }
        try node.assert("nestedArray", expectation: Node(na))

        let ao = try arrayOfObjects.map { try $0.makeNode() }
        try node.assert("arrayOfObjects", expectation: Node(ao))

        try node.assert("dictionary", expectation: Node(node: dictionary))

        let da = ["hello": ["a", "b", "c"]] as Node
        try node.assert("dictionaryWithArray", expectation: da)

        try node.assert("I.Live.Down.The.Road.At.0.Index", expectation: "path")

        try node.assert("person", expectation: try Node(node: dictionaryWithDictionary))
    }
}

extension Node {
    fileprivate func assert(_ key: String, expectation: NodeRepresentable?) throws {
        let expectation = try expectation?.makeNode()
        let value = self[path: key]
        XCTAssertEqual(value, expectation)
    }
}
