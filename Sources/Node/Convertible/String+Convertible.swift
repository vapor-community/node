extension String: NodeConvertible {
    public func makeNode(context: Context = Context.default) -> Node {
        return .string(self)
    }

    public init(node: Node, in context: Context) throws {
        guard let string = node.string else {
            throw NodeError(node: node, expectation: "\(String.self)")
        }
        self = string
    }
}
