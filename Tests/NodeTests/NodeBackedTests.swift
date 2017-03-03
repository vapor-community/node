import XCTest
import Node

struct JSON: StructuredDataWrapper {
    var wrapped: StructuredData
    var context: Context
    init(_ wrapped: StructuredData, in context: Context?) {
        self.wrapped = wrapped
        self.context = context ?? [String: Int]()
    }
}

class NodeBackedTests: XCTestCase {
    static let allTests = [
        ("testSubscripts", testSubscripts),
        ("testPolymorphic", testPolymorphic),
    ]

    func testSubscripts() throws {
        let json = try JSON(node: [
                "names": [
                    "",
                    "",
                    "World"
                ]
            ]
        )

        XCTAssertEqual(json["names", 2]?.string, "World")
    }

    func testPolymorphic() throws {
        let node = try JSON(
            node: [
                "string": "Hello!",
                "int": 3,
                "bool": true,
                "ob": [
                    "name": "World"
                ],
                "arr": [
                    0,
                    1,
                    2
                ],
                "null": "null",
                "double": 3.14
            ]
        )

        XCTAssertEqual(node["string"]?.string, "Hello!")
        XCTAssertEqual(node["int"]?.int, 3)
        XCTAssertEqual(node["bool"]?.bool, true)
        XCTAssertEqual(node["ob", "name"]?.string, "World")
        XCTAssertEqual(node["arr", 2]?.int, 2)
        XCTAssertEqual(node["null"]?.isNull, true)
        XCTAssertEqual(node["double"]?.double, 3.14)
        let arr = node["arr"]?.array?.flatMap { $0.int } ?? []
        XCTAssertEqual(arr, [0, 1, 2])
        let ob = node["ob"]?.object
        XCTAssertEqual(ob?["name"]?.string, "World")
        XCTAssertNil(node["int", "foo"]?.object)

        let jsArr: [JSON] = try [0, 1].map { try $0.converted(in: nil) }
        _ = JSON(jsArr)
        let jsOb: [String: JSON] = ["key": JSON(.string("val"), in: nil)]
        _ = JSON(jsOb)
    }
}
