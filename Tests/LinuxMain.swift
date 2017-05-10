#if os(Linux)
import XCTest
@testable import NodeFuzzyTests

XCTMain([
    testCase(BasicConvertibleTests.allTests),
    testCase(DictionaryKeyPathTests.allTests),
    testCase(NodeDataTypeTests.allTests),
    testCase(NodeGetterTests.allTests),
    testCase(NodeIndexableTests.allTests),
    testCase(NodePolymorphicTests.allTests),
    testCase(NodeTests.allTests),
    testCase(SequenceConvertibleTests.allTests),
    testCase(NumberTests.allTests),
    testCase(NodeBackedTests.allTests),
    testCase(SettersTests.allTests),
])
#endif
