extension Bool: NodeConvertible {
    public func makeNode(in context: Context? = nil) -> Node {
        return .bool(self)
    }

    public init(node: Node) throws {
        guard let bool = node.bool else {
            throw NodeError(node: node, expectation: "\(Bool.self)")
        }
        self = bool
    }
}
