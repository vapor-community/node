extension Dictionary: NodeConvertible {
    public init(node: Node) throws {
        guard Key.self is String.Type else {
            throw NodeError.invalidDictionaryKeyType
        }
        
        guard let object = node.object else {
            throw NodeError.unableToConvert(
                input: node,
                expectation: "\([Key: Value].self)",
                path: []
            )
        }

        var mapped: [Key: Value] = [:]
        try object.forEach { key, node in
            let key = key as! Key
            let val: Value = try Node.fuzzy.initialize(node: node)
            mapped[key] = val
        }
        self = mapped
    }

    public func makeNode(in context: Context?) throws -> Node {
        guard Key.self is String.Type else {
            throw NodeError.invalidDictionaryKeyType
        }
        
        var nodes: [String: Node] = [:]
        try forEach { (key, value) in
            nodes[key as! String] = try Node.fuzzy.represent(value, in: context)
        }
        
        return Node(nodes)
    }
}

extension StructuredDataWrapper {
    public mutating func set(_ path: String, _ any: [String: Any?]?) throws {
        try set(path, any.makeNode(in: context))
    }
}
