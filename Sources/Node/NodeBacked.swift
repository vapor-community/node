public typealias NodeBacked = SchemaWrapper
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

extension SchemaWrapper {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.schema == rhs.schema
    }
}

extension SchemaWrapper {
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

extension SchemaWrapper {
    public init() {
        self.init(schema: .object([:]), in: EmptyNode)
    }
}

// Convertible
extension SchemaWrapper {
    public init(node: Node) {
        self.init(schema: node.schema, in: node.context)
    }
    
    public func makeNode(in context: Context? = nil) -> Node {
        let context = context ?? self.context
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
    public var date: Date? { return schema.date }

    public var array: [Polymorphic]? {
        return schema.array
    }
    public var object: [String: Polymorphic]? {
        return schema.object
    }
}

// PathIndexable
extension SchemaWrapper {

    /**
        If self is an array representation, return array
    */
    public var pathIndexableArray: [Self]? {
        return schema.schemaArray?.map { Self(schema: $0, in: context) }
    }

    /**
        If self is an object representation, return object
    */
    public var pathIndexableObject: [String: Self]? {
        guard let o = schema.schemaObject else { return nil }
        var object: [String: Self] = [:]
        o.forEach { key, val in
            object[key] = Self(schema: val, in: context)
        }
        return object
    }

    /**
        Initialize json w/ array
    */
    public init(_ array: [Self]) {
        let schema = array.map { $0.schema }
        let node = Schema.array(schema)

        // take first context to attempt inference, should all be same
        let context = array.lazy.flatMap { $0.context } .first
        self.init(schema: node, in: context)
    }

    /**
        Initialize json w/ object
    */
    public init(_ o: [String: Self]) {
        var object: [String: Schema] = [:]
        for (key, val) in o {
            object[key] = val.schema
        }
        let schema = Schema.object(object)

        // take first context to attempt inference, should all be same
        let context = o.values.lazy.flatMap { $0.context } .first
        self.init(schema: schema, in: context)
    }
}

extension SchemaWrapper { // : ExpressibleByNilLiteral {
    public init(nilLiteral value: Void) {
        self = Self(.null)
    }
}

extension SchemaWrapper { // : ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = .bool(value)
    }
}

extension SchemaWrapper { // : ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = .number(.init(value))
    }
}

extension SchemaWrapper { // : ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .number(.init(value))
    }
}

extension SchemaWrapper { // : ExpressibleByStringLiteral {
    public init(unicodeScalarLiteral value: String) {
        self = .string(value)
    }

    public init(extendedGraphemeClusterLiteral value: String) {
        self = .string(value)
    }

    public init(stringLiteral value: String) {
        self = .string(value)
    }
}

extension SchemaWrapper { // : ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Self...) {
        self = .array(elements)
    }
}

extension SchemaWrapper { // : ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (String, Self)...) {
        var new = [String: Self]()
        elements.forEach { key, value in
            new[key] = value
        }
        self = .object(new)
    }
}
