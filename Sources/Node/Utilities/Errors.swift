@_exported import Debugging

public struct NodeError: Debuggable {
    public let node: Node?
    public let expectation: String
    public let path: String

    public let type: String = NodeError.unableToConvert // replacing the enum case to identify error type

    internal init<S: SchemaWrapper>(node: S?, expectation: String, indexers: [PathIndexer] = []) {
        self.node = node.flatMap { Node($0) }
        self.expectation = expectation
        self.path = indexers.path()
    }

    internal init(node: Node?, expectation: String, indexers: [PathIndexer] = []) {
        self.node = node
        self.expectation = expectation
        self.path = indexers.path()
    }
}

extension NodeError {
    public static var unableToConvert: String { return "unableToConvert" }
}

extension NodeError: CustomStringConvertible {
    public var description: String {
        return "Expected \(expectation) Got: \(node ?? .null) forPath: \(path)"
    }
}

extension NodeError {
    public var identifier: String {
        return type
    }

    public var reason: String {
        return "Unable to convert: `\(node ?? .null)` to expectation: `\(expectation)` forPath: `\(path)`"
    }

    public var possibleCauses: [String] {
        return [
            "typo in key path",
            "unexpected '.' being interpreted as path instead of key",
        ]
    }

    public var suggestedFixes: [String] {
        return [
            "ensure that key path matches expectation",
            "if you have keys containing a '.' that shouldn't be interpreted as a path, use 'DotKey(\"actual.key\")'",
        ]
    }
}
