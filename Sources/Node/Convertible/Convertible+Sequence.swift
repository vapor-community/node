extension Sequence where Iterator.Element: NodeRepresentable {
    public func toNode() throws -> Node {
        let array = try map { try $0.toNode() }
        return Node(array)
    }
    public func converted<T: NodeRepresentable>(to type: T.Type = T.self) throws -> T {
        return try toNode().converted()
    }
}

extension Dictionary where Key: CustomStringConvertible, Value: NodeRepresentable {
    public func toNode() throws -> Node {
        var mutable: [String : Node] = [:]
        try self.forEach { key, value in
            mutable["\(key)"] = try value.toNode()
        }
        return .object(mutable)
    }

    public func converted<T: NodeRepresentable>(to type: T.Type = T.self) throws -> Node {
        return try toNode().converted()
    }
}

// MARK: From Node

public extension Array where Element : NodeInitializable {
    public init<T: NodeRepresentable>(
        with convertible: T,
        in context: Context = EmptyNode) throws {
        let node = try convertible.toNode()
        let array = node.nodeArray ?? [node]
        try self.init(with: array, in: context)
    }

    public init<S: Sequence where S.Iterator.Element: NodeRepresentable>(
        with convertible: S,
        in context: Context = EmptyNode) throws {
        self = try convertible
            .map { try $0.toNode() }
            .map { try Element.init(with: $0, in: context) }
    }
}

public extension Set where Element : NodeInitializable {
    public init<T: NodeRepresentable>(
        with convertible: T,
        in context: Context = EmptyNode) throws {
        let node = try convertible.toNode()
        let array = node.nodeArray ?? [node]
        try self.init(with: array, in: context)
    }

    public init<S: Sequence where S.Iterator.Element: NodeRepresentable>(
        with convertible: S,
        in context: Context = EmptyNode) throws {
        let array = try convertible
            .map { try $0.toNode() }
            .map { try Element.init(with: $0, in: context) }
        self.init(array)
    }
}
