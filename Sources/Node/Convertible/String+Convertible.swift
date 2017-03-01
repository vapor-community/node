extension String: NodeConvertible {
    public func makeNode(in context: Context = EmptyNode) -> Node {
        return .string(self)
    }

    public init(node: Node) throws {
        guard let string = node.string else {
            throw NodeError(node: node, expectation: "\(String.self)")
        }
        self = string
    }
}
