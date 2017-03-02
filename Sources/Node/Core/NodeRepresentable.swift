public protocol NodeRepresentable {
    /// Able to be represented as a Node
    ///
    /// - throws: if convertible can not create a Node
    /// - returns: a node if possible
    func makeNode(in context: Context?) throws -> Node
}

extension NodeRepresentable {
    public func makeNode() throws -> Node {
        return try makeNode(in: nil)
    }
}

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
