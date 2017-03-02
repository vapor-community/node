extension Dictionary: NodeConvertible {
    public init(node: Node) throws {
        guard Key.self is String.Type, Value.self is NodeInitializable.Type else { throw TypeError.notValid }
        guard let object = node.typeObject else { throw NodeError(node: node, expectation: "\([Key: Value].self)") }
        let value = Value.self as! NodeInitializable.Type

        var mapped: [Key: Value] = [:]

        try object.forEach { key, node in
            let key = key as! Key
            let val = try value.init(node: node) as! Value
            mapped[key] = val
        }

        self = mapped
    }

    public func makeNode(in context: Context?) throws -> Node {
        guard Key.self is String.Type, Value.self is NodeRepresentable.Type else { throw TypeError.notValid }

        var mapped: [String: Node] = [:]
        try forEach { key, value in
            let key = key as! String
            let value = value as! NodeRepresentable
            mapped[key] = try value.makeNode(in: context)
        }
        return Node(mapped)
    }
}
