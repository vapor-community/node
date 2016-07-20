#if os(Linux)
import XCTest
@testable import NodeTestSuite

XCTMain([
    testCase(BasicConvertibleTests.allTests),
    testCase(DictionaryKeyPathTests.allTests),
    testCase(NodeDataTypeTests.allTests),
    testCase(NodeIndexableTests.allTests),
    testCase(NodePolymorphicTests.allTests),
    testCase(NodeTests.allTests),
    testCase(SequenceConvertibleTests.allTests),
    testCase(NumberTests.allTests),
])
#endif
