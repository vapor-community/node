extension StructuredData: NodeConvertible {
    public init(node: Node) {
        self = node.wrapped
    }

    public func makeNode(in context: Context? = nil) -> Node {
        return Node(self)
    }
}
