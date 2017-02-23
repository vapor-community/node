public struct NodeError: Swift.Error {
    public let node: Node?
    public let expectation: String
    public let path: String

    public let type: String = NodeError.unableToConvert // replacing the enum case to identify error type

    internal init(node: Node?, expectation: String, indexers: [PathIndexer] = []) {
        self.node = node
        self.expectation = expectation
        self.path = indexers.path()
    }
}

extension NodeError {
    static let unableToConvert = "unableToConvert"
}

extension NodeError: CustomStringConvertible {
    public var description: String {
        return "Expected \(expectation) Got: \(node ?? .null) forPath: \(path)"
    }
}
