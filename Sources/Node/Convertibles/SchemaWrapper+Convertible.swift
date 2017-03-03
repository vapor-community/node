extension StructuredDataWrapper {
    public func makeNode(in context: Context? = nil) -> Node {
        let context = context ?? self.context
        return Node(wrapped, in: context)
    }
}
