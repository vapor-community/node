#if os(Linux)
import XCTest
@testable import NodeTestSuite

XCTMain([
    testCase(DictionaryKeyPathTests.allTests),
    testCase(NodeDataTypeTest.allTests),
    testCase(NodeIndexable.allTests),
])
#endif
