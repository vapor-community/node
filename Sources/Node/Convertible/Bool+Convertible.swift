extension Bool: NodeConvertible {
    public func makeNode(context: Context = .default) -> Node {
        return .bool(self)
    }

    public init(node: Node, in context: Context) throws {
        guard let bool = node.bool else {
            throw NodeError(node: node, expectation: "\(Bool.self)")
        }
        self = bool
    }
}
