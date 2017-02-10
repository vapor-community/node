extension Bool: NodeConvertible {
    public func makeNode(context: Context = EmptyNode) -> Node {
        return .bool(self)
    }

    public init(node: Node, in context: Context) throws {
        guard let bool = node.bool else {
            throw NodeError(node: node, expectation: "\(Bool.self)", key: nil)
        }
        self = bool
    }
}
