extension Schema: NodeConvertible {
    public init(node: Node) {
        self = node.schema
    }

    public func makeNode(in context: Context? = nil) -> Node {
        return Node(self)
    }
}
