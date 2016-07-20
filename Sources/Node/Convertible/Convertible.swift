public protocol NodeRepresentable {
    /**
        Turn the convertible into a node

        - throws: if convertible can not create a Node
        - returns: a node if possible
    */
    func makeNode() throws -> Node
}

public protocol NodeInitializable {
    /**
        Initialize the convertible with a node within a context.

        Context is an empty protocol to which any type can conform.
        This allows flexibility. for objects that might require access
        to a context outside of the node ecosystem
    */
    init(with node: Node, in context: Context) throws

    /**
        Optional initializer for customizable default behavior
    */
    init(with node: Node) throws
}

extension NodeInitializable {
    /**
        Default initializer for cases where a custom Context is not required
    */
    public init(with node: Node) throws {
        try self.init(with: node, in: EmptyNode)
    }
}

/**
    The underlying protocol used for all conversions.
    This is the base of all conversions, where both sides of data are NodeConvertible.
    Any NodeConvertible can be turned into any other NodeConvertible type

        Json => Node => Object => Node => XML => ...
*/
public protocol NodeConvertible: NodeInitializable, NodeRepresentable {}
