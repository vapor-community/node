extension Bool: NodeConvertible {
    public func makeNode() -> Node {
        return .bool(self)
    }

    public init(node: Node, in context: Context) throws {
        guard let bool = node.bool else {
            throw NodeError.unableToConvert(node: node, expected: "\(Bool.self)")
        }
        self = bool
    }
}
