extension Dictionary: NodeConvertible {
    public init(node: Node) throws {
        guard
            let object = node.typeObject,
            Key.self is String.Type,
            let value = Value.self as? NodeInitializable.Type
            else { throw TypeError.notValid }

        var mapped: [String: NodeInitializable] = [:]
        try object.forEach { key, node in
            mapped[key] = try value.init(node: node)
        }
        self = mapped as! [Key: Value]
    }

    public func makeNode(in context: Context?) throws -> Node {
        guard let representable = self as? [String: NodeRepresentable] else {
            // TODO: BETTER ERROR
            throw TypeError.notValid
        }

        var mapped: [String: Node] = [:]
        try representable.forEach { key, value in
            mapped[key] = try value.makeNode(in: context)
        }
        return Node(mapped)
    }
}
