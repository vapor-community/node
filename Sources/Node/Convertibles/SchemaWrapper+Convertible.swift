extension SchemaWrapper {
    public init(node: Node) {
        self.init(schema: node.schema, in: node.context)
    }

    public func makeNode(in context: Context? = nil) -> Node {
        let context = context ?? self.context
        return Node(schema: schema, in: context)
    }
}
