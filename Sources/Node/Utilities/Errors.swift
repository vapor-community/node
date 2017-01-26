public enum NodeError: Swift.Error {
    /**
        Unable to convert a given node to the target type.

        - param node: the node that was unable to convert
        - param expected: a description of the type Genome was trying to convert to
    */
    case unableToConvert(node: Node?, expected: String, key: [PathIndex]?)
    
    var localizedDescription: String {
        switch self {
        case let .unableToConvert(node, expected, key):
            if let key = key {
                return "Expected \(expected) \(key.map { $0.string }) to be found on \(node?.string ?? "node")."
            } else {
                return "unableToConvert(\(node), expected: \(expected))"
            }
        }
    }
}
