import Bits

public protocol NodeRepresentable {
    /**
        Turn the convertible into a node

        - throws: if convertible can not create a Node
        - returns: a node if possible
    */
    func makeNode(in context: Context?) throws -> Node
}

extension NodeRepresentable {
    public func makeNode() throws -> Node {
        return try makeNode(in: EmptyNode)
    }
}

public protocol NodeInitializable {
    /**
        Initialize the convertible with a node within a context.

        Context is an empty protocol to which any type can conform.
        This allows flexibility. for objects that might require access
        to a context outside of the node ecosystem
    */
    init(node: Node) throws
}

extension NodeInitializable {
    public init(node: Schema, in context: Context) throws {
        let node = Node(schema: node, in: context)
        try self.init(node: node)
    }
}

public struct Node: SchemaWrapper {
    public var schema: Schema
    public let context: Context

    public init(schema: Schema, in context: Context) {
        self.schema = schema
        self.context = context
    }
}

extension Node {
    public var nodeArray: [Node]? { return schema.schemaArray?.map { Node(schema: $0, in: context) } }
    public var nodeObject: [String: Node]? {
        guard let object = schema.schemaObject else { return nil }
        var new = [String: Node]()
        object.forEach { key, value in
            new[key] = Node(schema: value, in: context)
        }
        return new
    }
}
extension SchemaWrapper {
    public static var null: Self { return Self(.null) }
    public static func bool(_ val: Bool) -> Self { return Self(.bool(val)) }
    public static func date(_ val: Date) -> Self { return Self(.date(val)) }
    public static func number(_ val: Schema.Number) -> Self { return Self(.number(val)) }
    public static func string(_ val: String) -> Self { return Self(.string(val)) }
    public static func bytes(_ val: Bytes) -> Self { return Self(.bytes(val)) }
    public static func object<S: SchemaWrapper>(_ val: [String: S]) -> Self {
        var new = [String: Schema]()
        val.forEach { key, value in
            new[key] = value.schema
        }

        return Self(schema: .object(new), in: val.values.first?.context ?? EmptyNode) // context should be same for all
    }
    public static func object(_ val: [String: Self]) -> Self {
        var new = [String: Schema]()
        val.forEach { key, value in
            new[key] = value.schema
        }

        return Self(schema: .object(new), in: val.values.first?.context ?? EmptyNode) // context should be same for all
    }
    public static func array<S: SchemaWrapper>(_ val: [S]) -> Self {
        let new = val.map { $0.schema }
        return Self(schema: .array(new), in: val.first?.context ?? EmptyNode) // context should be same for all
    }
    public static func array(_ val: [Self]) -> Self {
        let new = val.map { $0.schema }
        return Self(schema: .array(new), in: val.first?.context ?? EmptyNode) // context should be same for all
    }
}

/**
    The underlying protocol used for all conversions.
    This is the base of all conversions, where both sides of data are NodeConvertible.
    Any NodeConvertible can be turned into any other NodeConvertible type

        Json => Node => Object => Node => XML => ...
*/
public protocol NodeConvertible: NodeInitializable, NodeRepresentable {}
