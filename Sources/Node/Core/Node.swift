public struct Node: StructuredDataWrapper {
    public var wrapped: StructuredData
    public var context: Context

    public init(_ wrapped: StructuredData, in context: Context) {
        self.wrapped = wrapped
        self.context = context
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
