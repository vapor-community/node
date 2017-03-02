extension Bool: NodeConvertible {
    public init(node: Node) throws {
        guard let bool = node.bool else {
            throw Error.unableToConvert(input: node, expectation: "\(Bool.self)", path: [])
        }
        self = bool
    }

    public func makeNode(in context: Context? = nil) -> Node {
        return .bool(self)
    }
}
