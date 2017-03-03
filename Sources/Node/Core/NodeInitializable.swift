public protocol NodeInitializable {
    /// Initialize the convertible with a node within a context.
    ///
    /// Context is an empty protocol to which any type can conform.
    /// This allows flexibility. for objects that might require access
    /// to a context outside of the node ecosystem
    init(node: Node) throws
}

extension NodeInitializable {
    public init<W: StructuredDataWrapper>(node: W) throws {
        let node = Node(node)
        try self.init(node: node)
    }

    public init(node representable: NodeRepresentable?, in context: Context? = nil) throws {
        let node = try representable?.makeNode(in: context) ?? Node(.null, in: context)
        try self.init(node: node)
    }
}
