extension NodeRepresentable {
    /**
     Map the node back to a convertible type

     - parameter type: the type to map to -- can be inferred
     - throws: if mapping fails
     - returns: convertible representation of object
     */
    public func converted<T: NodeInitializable>(
        to type: T.Type = T.self,
        in context: Context = EmptyNode) throws -> T {
        let node = try makeNode()
        return try type.init(with: node, in: context)
    }
}

extension NodeInitializable {
    public init(_ representable: NodeRepresentable, in context: Context = EmptyNode) throws {
        let node = try representable.makeNode()
        try self.init(with: node, in: context)
    }

    public init(_ representable: NodeRepresentable?, in context: Context = EmptyNode) throws {
        let node = try representable?.makeNode() ?? .null
        try self.init(with: node, in: context)
    }
}
