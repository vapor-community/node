public struct Node: SchemaWrapper {
    public var schema: Schema
    public var context: Context

    public init(schema: Schema, in context: Context) {
        self.schema = schema
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
