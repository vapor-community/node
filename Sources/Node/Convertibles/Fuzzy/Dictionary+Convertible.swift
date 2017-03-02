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
        let object = try representable()

        var mapped: [String: Node] = [:]
        try object.forEach { key, value in
            mapped[key] = try value.makeNode(in: context)
        }
        return Node(mapped)
    }
}

extension Dictionary {
    fileprivate func representable() throws -> [String: NodeRepresentable] {
        guard Key.self is String.Type else { throw TypeError.notValid }

        var object: [String: NodeRepresentable] = [:]
        try forEach { key, value in
            let key = key as! String
            guard let value = value as? NodeRepresentable else { throw TypeError.notValid }
            object[key] = value
        }

        // make sure we're 100% representable
        guard object.count == count else { throw TypeError.notValid }
        return object
    }
}
