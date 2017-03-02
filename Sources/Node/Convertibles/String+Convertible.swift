extension String: NodeConvertible {
    public init(node: Node) throws {
        guard let string = node.string else {
            throw NodeError(node: node, expectation: "\(String.self)")
        }
        self = string
    }

    public func makeNode(in context: Context? = nil) -> Node {
        return .string(self)
    }
}
