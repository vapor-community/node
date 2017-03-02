
/// The underlying protocol used for all conversions.
/// This is the base of all conversions, where both sides of data are NodeConvertible.
/// Any NodeConvertible can be turned into any other NodeConvertible type
///
/// Json => Node => Object => Node => XML => ...
public protocol NodeConvertible: NodeInitializable, NodeRepresentable {}

public protocol NodeInitializable {
    /// Initialize the convertible with a node within a context.
    ///
    /// Context is an empty protocol to which any type can conform.
    /// This allows flexibility. for objects that might require access
    /// to a context outside of the node ecosystem
    init(node: Node) throws
}

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
