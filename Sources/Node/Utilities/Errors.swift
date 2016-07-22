public enum NodeError: Error {
    /**
        Unable to convert a given node to the target type.

        - param node: the node that was unable to convert
        - param expected: a description of the type Genome was trying to convert to
    */
    case unableToConvert(node: Node, expected: String)
}

internal struct ErrorFactory {
    static func unableToConvert<T>(_ node: Node,
                                   to type: T.Type) -> Error {
        let error = NodeError.unableToConvert(node: node,
                                          expected: "\(type)")
        return error
    }
}
