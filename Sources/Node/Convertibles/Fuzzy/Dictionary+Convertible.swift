extension Dictionary: NodeConvertible {
    public init(node: Node) throws {
        guard Key.self is String.Type, Value.self is NodeInitializable.Type else {
            throw NodeError.invalidContainer(container: "\(Dictionary.self)", element: "\(Value.self)")
        }
        guard let object = node.object else {
            throw NodeError.unableToConvert(input: node, expectation: "\([Key: Value].self)", path: [])
        }

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
        guard Key.self is String.Type else {
            throw NodeError.invalidContainer(
                container: "\(Dictionary.self)",
                element: "Key(\(Key.self)) (expected String)"
            )
        }

        var object: [String: NodeRepresentable] = [:]
        try forEach { key, value in
            let key = key as! String
            guard let rep = value as? NodeRepresentable else {
                throw NodeError.invalidContainer(container: "\(Dictionary.self)", element: "\(String(describing: value))")
            }
            object[key] = rep
        }

        return object
    }
}
