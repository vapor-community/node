public struct NodeError: Swift.Error {
    public let node: Node?
    public let expectation: String
    public let key: [PathIndex]?

    public let type: String = NodeError.unableToConvert // replacing the enum case to identify error type
}

extension NodeError {
    static let unableToConvert = "unableToConvert"
}

extension NodeError: CustomStringConvertible {
    public var description: String {
        return "Expected \(expectation)\nGot: \(node ?? .null)\nKey: \(key ?? [])"
    }
}
