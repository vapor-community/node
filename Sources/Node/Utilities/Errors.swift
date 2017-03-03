@_exported import Debugging

public enum NodeError: Debuggable {
    case invalidContainer(container: String, element: String)
    case unableToConvert(input: Node?, expectation: String, path: [PathIndexer])
}

extension NodeError {
    public var identifier: String {
        switch self {
        case .invalidContainer:
            return "invalidType"
        case .unableToConvert:
            return "unableToConvert"
        }
    }

    public var reason: String {
        switch self {
        case .invalidContainer(let container, let element):
            return "Unable to use container '\(container)' with element '\(element)' expected a \(NodeConvertible.self) type"
        case .unableToConvert(let node, let expectation, let path):
            let path = path.map { "\($0)" } .joined(separator: ".")
            if let node = node, node != .null {
                return "Unable to convert '\(node)' to '\(expectation)' for path '\(path)'"
            } else {
                return "No value found at path '\(path)', expected '\(expectation)'"
            }
        }
    }

    public var possibleCauses: [String] {
        switch self {
        case .invalidContainer:
            return [
                "tried to use a collection (Optional, Array, Dictionary, Set) that doesn't contain NodeConvertible types"
            ]
        case .unableToConvert:
            return [
                "typo in key path",
                "underlying type is not convertible",
                "unexpected '.' being interpreted as path instead of key",
            ]
        }
    }

    public var suggestedFixes: [String] {
        switch self {
        case .invalidContainer(_, let element):
            return [
                "ensure that '\(element)' conforms to '\(NodeConvertible.self)'",
                "if '\(element)' is itself a collection (Optional, Array, Dictionary, Set), then ensure it's elements are '\(NodeConvertible.self)'",
                "if the element type is `Any`, then manually inspect to ensure all elements contained conform to '\(NodeConvertible.self)'",
                "if container is a dictionary, ensure Key is type String, and Value is '\(NodeConvertible.self)'"
            ]
        case .unableToConvert:
            return [
                "called `get(...)` on a key or key path that does not exist in the data",
                "the data being parsed is missing required values or is incorrectly formatted",
                "found unconvertible data, e.g., got a string of letters when an integer is required",
                "if you have keys containing a '.' that shouldn't be interpreted as a path, use 'DotKey(\"actual.key\")'",
            ]
        }
    }
}

//public struct NodeError: Debuggable {
//    public let node: Node?
//    public let expectation: String
//    public let path: String
//
//    public let type: String = NodeError.unableToConvert // replacing the enum case to identify error type
//
//    internal init<S: StructuredDataWrapper>(node: S?, expectation: String, indexers: [PathIndexer] = []) {
//        self.node = node.flatMap { Node($0) }
//        self.expectation = expectation
//        self.path = indexers.path()
//    }
//
//    internal init(node: Node?, expectation: String, indexers: [PathIndexer] = []) {
//        self.node = node
//        self.expectation = expectation
//        self.path = indexers.path()
//    }
//}
//
//extension NodeError {
//    public static var unableToConvert: String { return "unableToConvert" }
//}
//
//extension NodeError: CustomStringConvertible {
//    public var description: String {
//        return "Expected \(expectation) Got: \(node ?? .null) forPath: \(path)"
//    }
//}
//
//extension NodeError {
//    public var identifier: String {
//        return type
//    }
//
//    public var reason: String {
//        return "Unable to convert: `\(node ?? .null)` to expectation: `\(expectation)` forPath: `\(path)`"
//    }
//
//    public var possibleCauses: [String] {
//        return [
//            "typo in key path",
//            "unexpected '.' being interpreted as path instead of key",
//        ]
//    }
//
//    public var suggestedFixes: [String] {
//        return [
//            "ensure that key path matches expectation",
//            "if you have keys containing a '.' that shouldn't be interpreted as a path, use 'DotKey(\"actual.key\")'",
//        ]
//    }
//}
