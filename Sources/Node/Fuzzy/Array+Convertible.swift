extension Array: NodeConvertible {
    public init(node: Node) throws {
        let array = node.array ?? [node]
        
        self = try array.map { n in
            return try Node.fuzzy.initialize(node: n)
        }
    }

    public func makeNode(in context: Context?) throws -> Node {
        let nodes: [Node] = try map { item in
            return try Node.fuzzy.represent(item, in: context)
        }
        return Node(nodes)
    }
}

extension StructuredDataWrapper {
    public mutating func set(_ path: String, _ any: [Any?]?) throws {
        try set(path, any.makeNode(in: context))
    }
}
