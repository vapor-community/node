extension NodeBacked {
    public mutating func set(_ path: String, _ value: NodeRepresentable?) throws {
        let node = try value.flatMap { try Node(node: $0) }
        self.node[path: path] = node
    }

    public mutating func set(_ path: String, _ value: [NodeRepresentable?]?) throws {
        let node = try value.flatMap { try Node(node: $0) }
        self.node[path: path] = node
    }

    public mutating func set(_ path: String, _ value: [[NodeRepresentable?]?]?) throws {
        let node = try value.flatMap { try Node(node: $0) }
        self.node[path: path] = node.flatMap(Node.init)
    }

    public mutating func set(_ path: String, _ value: [[String: NodeRepresentable?]?]?) throws {
        let node = try value.flatMap { try Node(node: $0) }
        self.node[path: path] = node.flatMap(Node.init)
    }

    public mutating func set(_ path: String, _ value: [String: NodeRepresentable?]?) throws {
        let node = try value.flatMap { try Node(node: $0) }
        self.node[path: path] = node
    }

    public mutating func set(_ path: String, _ value: [String: [NodeRepresentable?]?]?) throws {
        let node = try value.flatMap { try Node(node: $0) }
        self.node[path: path] = node
    }

    public mutating func set(_ path: String, _ value: [String: [String: NodeRepresentable?]?]?) throws {
        let node = try value.flatMap { try Node(node: $0) }
        self.node[path: path] = node
    }
}
