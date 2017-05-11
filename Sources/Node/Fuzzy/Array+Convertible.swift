@_exported import Node

extension Array: NodeConvertible {
    public init(node: Node) throws {
        let array = node.array ?? [node]
        
        self = try array.map { item in
            return try Node.fuzzy.initialize(item.wrapped, in: item.context)
        }
    }

    public func makeNode(in context: Context?) throws -> Node {
        let nodes: [Node] = try map { item in
            let wrapped = try Node.fuzzy.represent(item, in: context)
            return Node(wrapped, in: context)
        }
        return Node(nodes)
    }
}

extension String: Error { }
