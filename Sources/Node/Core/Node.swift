public struct Node: StructuredDataWrapper {
    public static let defaultContext = emptyContext
    
    public var wrapped: StructuredData
    public var context: Context

    public init(_ wrapped: StructuredData, in context: Context?) {
        self.wrapped = wrapped
        self.context = context ?? emptyContext
    }
}

extension Node: NodeConvertible {
    public init(node: Node) {
        self = node
    }

    public func makeNode(in context: Context?) -> Node {
        return self
    }
}
