
#if os(Linux)

import XCTest
@testable import GenomeTestSuite

XCTMain([
    testCase(DictionaryKeyPathTests.allTests),
    testCase(NodeDataTypeTest.allTests),
    testCase(NodeIndexable.allTests),
])

#endif
