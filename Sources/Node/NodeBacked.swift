public protocol SchemaWrapper: NodeConvertible, PathIndexable, Polymorphic {
    var schema: Schema { get set }
    var context: Context { get }
    init(schema: Schema, in context: Context)
}

extension SchemaWrapper {
    public init(_ schema: Schema) {
        self.init(schema: schema, in: EmptyNode)
    }

    public init(_ context: Context) {
        self.init(schema: Schema(), in: context)
    }

    public init<S: SchemaWrapper>(_ wrapper: S) {
        self.init(schema: wrapper.schema, in: wrapper.context)
    }
}

// Convertible
extension SchemaWrapper {
    public init(node: Node) {
        self.init(schema: node.schema, in: node.context)
    }
    
    public func makeNode(in context: Context = EmptyNode) -> Node {
        return Node(schema: schema, in: context)
    }
}

// Polymorphic
extension SchemaWrapper {
    public var isNull: Bool { return schema.isNull }
    public var bool: Bool? { return schema.bool }
    public var double: Double? { return schema.double }
    public var int: Int? { return schema.int }
    public var string: String? { return schema.string }
    public var bytes: [UInt8]? { return schema.bytes }

    public var array: [Polymorphic]? {
        return schema.schemaArray?.map { Self($0) }
    }
    public var object: [String: Polymorphic]? {
        return schema.schemaObject.flatMap { ob in
            var result = [String: Polymorphic]()
            ob.forEach { k, v in
                result[k] = Self(v)
            }
            return result
        }
    }
}

// PathIndexable
extension SchemaWrapper {

    /**
        If self is an array representation, return array
    */
    public var pathIndexableArray: [Self]? {
        return schema.schemaArray?.map { Self($0) }
    }

    /**
        If self is an object representation, return object
    */
    public var pathIndexableObject: [String: Self]? {
        guard let o = schema.schemaObject else { return nil }
        var object: [String: Self] = [:]
        for (key, val) in o {
            object[key] = Self(val)
        }
        return object
    }

    /**
        Initialize json w/ array
    */
    public init(_ array: [Self]) {
        let array = array.map { $0.schema }
        let node = Schema.array(array)
        self.init(node)
    }

    /**
        Initialize json w/ object
    */
    public init(_ o: [String: Self]) {
        var object: [String: Schema] = [:]
        for (key, val) in o {
            object[key] = val.schema
        }
        let node = Schema.object(object)
        self.init(node)
    }
}
