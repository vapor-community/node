public let EmptyNode = Node.object([:])

// MARK: Context

/**
 Sometimes convertible operations require a greater context beyond
 just a Node.

 Any object can conform to Context and be included in initialization
 */
public protocol Context {}

extension Node : Context {}
extension Array : Context {}
extension Dictionary : Context {}

// MARK: NodeConvertible

public protocol NodeRepresentable {
    /**
     Turn the convertible back into a node

     - throws: if convertible can not create a Node

     - returns: a node if possible
     */
    func toNode() throws -> Node
}

public protocol NodeInitializable {
    /**
     Initialiize the convertible with a node within a context.

     Context is an empty protocol to which any type can conform.
     This allows flexibility. for objects that might require access
     to a context outside of the json ecosystem
     */
    init(with node: Node, in context: Context) throws
}

extension NodeInitializable {
    public init(with node: Node) throws {
        try self.init(with: node, in: node)
    }
}

/**
 The underlying protocol used for all conversions. 
 
 This is the base of all conversions, where both sides of data are NodeConvertible.
 
 Any NodeConvertible can be turned into any other NodeConvertible type
 
 Json => Node => Object
 */
public protocol NodeConvertible: NodeInitializable, NodeRepresentable {}
