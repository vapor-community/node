extension StructuredDataWrapper {
    public init<S: StructuredDataWrapper>(_ wrapper: S) {
        self.init(wrapper.wrapped, in: wrapper.context)
    }

    public init(node: StructuredData, in context: Context? = Self.defaultContext) {
        self.init(node, in: context)
    }

    public init(node: NodeRepresentable, in context: Context? = Self.defaultContext) throws {
        let node = try node.makeNode(in: context)
        self.init(node)
    }
}
