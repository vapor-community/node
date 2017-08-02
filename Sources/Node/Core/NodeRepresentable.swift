public protocol NodeRepresentable {
    /// Able to be represented as a Node
    ///
    /// - throws: if convertible can not create a Node
    /// - returns: a node if possible
    func makeNode(in context: Context?) throws -> Node
}

extension NodeRepresentable {
    /**
     Map the node back to a convertible type

     - parameter type: the type to map to -- can be inferred
     - throws: if mapping fails
     - returns: convertible representation of object
     */
    public func converted<T: NodeInitializable>(
        to type: T.Type,
        in context: Context?
    ) throws -> T {
        return try converted(in: context) as T
    }

    /// Map the node back to a convertible type
    ///
    /// - parameter type: the type to map to -- can be inferred
    /// - throws: if mapping fails
    /// - returns: convertible representation of object
    public func converted<T: NodeInitializable>(
        in context: Context?
    ) throws -> T {
        let node = try makeNode(in: context)
        return try T.init(node: node)
    }
}
