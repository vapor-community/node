extension String: NodeConvertible {
    public func makeNode(context: Context = EmptyNode) -> Node {
        return .string(self)
    }

    public init(node: Node, in context: Context) throws {
        guard let string = node.string else {
            throw NodeError(node: node, expectation: "\(String.self)", key: nil)
        }
        self = string
    }
}
