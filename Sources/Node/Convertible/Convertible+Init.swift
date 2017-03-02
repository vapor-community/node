extension NodeRepresentable {
    /**
     Map the node back to a convertible type

     - parameter type: the type to map to -- can be inferred
     - throws: if mapping fails
     - returns: convertible representation of object
     */
    public func converted<T: NodeInitializable>(
        to type: T.Type = T.self,
        in context: Context? = nil
    ) throws -> T {
        let node = try makeNode(in: context)
        return try type.init(node: node)
    }
}

extension NodeInitializable {
    public init(node representable: NodeRepresentable?, in context: Context? = nil) throws {
        let node = try representable?.makeNode(in: context) ?? Node(schema: .null, in: context)
        try self.init(node: node)
    }
}
