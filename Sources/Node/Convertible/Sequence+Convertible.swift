extension Sequence where Iterator.Element: NodeRepresentable {
    public func makeNode() throws -> Node {
        let array = try map { try $0.makeNode() }
        return Node(array)
    }

    public func converted<T: NodeInitializable>(to type: [T].Type = [T].self) throws -> [T] {
        return try map { try $0.converted() }
    }
}

extension Sequence where Iterator.Element == NodeRepresentable {
    public func makeNode() throws -> Node {
        let array = try map { try $0.makeNode() }
        return Node(array)
    }

    public func converted<T: NodeInitializable>(to type: [T].Type = [T].self) throws -> [T] {
        return try map { try $0.converted() }
    }
}

extension Dictionary where Key: ExpressibleByStringLiteral, Value: NodeRepresentable {
//extension Sequence where Iterator.Element == (Key: String, Value: String) {
    public func makeNode() throws -> Node {
        var mutable: [String : Node] = [:]
        try self.forEach { key, value in
            mutable["\(key)"] = try value.makeNode()
        }
        return .object(mutable)
    }

    public func converted<T: NodeInitializable>(to type: T.Type = T.self) throws -> T {
        return try makeNode().converted()
    }
}

// MARK: From Node

public extension Array where Element : NodeInitializable {
    public init<T: NodeRepresentable>(
        node convertible: T,
        in context: Context = EmptyNode
    ) throws {
        let node = try convertible.makeNode()
        let array = node.nodeArray ?? [node]
        try self.init(node: array, in: context)
    }

    public init<S: Sequence>(
        node convertible: S,
        in context: Context = EmptyNode
    ) throws where S.Iterator.Element: NodeRepresentable {
        self = try convertible
            .map { try $0.makeNode() }
            .map { try Element(node: $0, in: context) }
    }

    public init<S: Sequence>(
        node convertible: S,
        in context: Context = EmptyNode
    ) throws where S.Iterator.Element == NodeRepresentable {
        self = try convertible
            .map { try $0.makeNode() }
            .map { try Element(node: $0, in: context) }
    }
}

public extension Set where Element : NodeInitializable {
    public init<T: NodeRepresentable>(
        node convertible: T,
        in context: Context = EmptyNode
    ) throws {
        let node = try convertible.makeNode()
        let array = node.nodeArray ?? [node]
        try self.init(node: array, in: context)
    }

    public init<S: Sequence>(
        node convertible: S,
        in context: Context = EmptyNode
    ) throws where S.Iterator.Element: NodeRepresentable {
        let array = try convertible
            .map { try $0.makeNode() }
            .map { try Element(node: $0, in: context) }
        self.init(array)
    }

    public init<S: Sequence>(
        node convertible: S,
        in context: Context = EmptyNode
    ) throws where S.Iterator.Element == NodeRepresentable {
        let array = try convertible
            .map { try $0.makeNode() }
            .map { try Element(node: $0, in: context) }
        self.init(array)
    }
}
