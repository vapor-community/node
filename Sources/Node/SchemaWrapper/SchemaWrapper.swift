public protocol SchemaWrapper:
    NodeConvertible,
    PathIndexable,
    Polymorphic,
    Equatable,
    ExpressibleByNilLiteral,
    ExpressibleByBooleanLiteral,
    ExpressibleByIntegerLiteral,
    ExpressibleByFloatLiteral,
    ExpressibleByStringLiteral,
    ExpressibleByArrayLiteral,
    ExpressibleByDictionaryLiteral
{
    var schema: Schema { get set }
    var context: Context { get }
    init(schema: Schema, in context: Context)
}

// MARK: Convenience 

extension SchemaWrapper {
    public init() {
        self.init(schema: .object([:]), in: EmptyNode)
    }

    public init(_ schema: Schema) {
        self.init(schema: schema, in: nil)
    }

    public init(_ context: Context) {
        self.init(schema: Schema(), in: context)
    }

    public init<S: SchemaWrapper>(_ wrapper: S) {
        self.init(schema: wrapper.schema, in: wrapper.context)
    }

    public init(schema: Schema, in context: Context?) {
        self.init(schema: schema, in: context ?? EmptyNode)
    }
}

// MARK: NodeConvertible

extension SchemaWrapper {
    public init(node: Node) {
        self.init(schema: node.schema, in: node.context)
    }
    
    public func makeNode(in context: Context? = nil) -> Node {
        let context = context ?? self.context
        return Node(schema: schema, in: context)
    }
}

// MARK: Equatable

extension SchemaWrapper {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.schema == rhs.schema
    }
}
