extension NodeBacked {
    public mutating func set(_ path: String, _ value: NodeRepresentable?) throws {
        let node = try value.flatMap { try Node(node: $0) }
        self.node[path] = node
    }

    public mutating func set(_ path: String, _ value: [NodeRepresentable?]?) throws {
        let node = try value.flatMap { try Node(node: $0) }
        self.node[path] = node
    }

    public mutating func set(_ path: String, _ value: [[NodeRepresentable?]?]?) throws {
        let node = try value.flatMap { try Node(node: $0) }
        self.node[path] = node.flatMap(Node.init)
    }

    public mutating func set(_ path: String, _ value: [[String: NodeRepresentable?]?]?) throws {
        let node = try value.flatMap { try Node(node: $0) }
        self.node[path] = node.flatMap(Node.init)
    }

    public mutating func set(_ path: String, _ value: [String: NodeRepresentable?]?) throws {
        let node = try value.flatMap { try Node(node: $0) }
        self.node[path] = node
    }

    public mutating func set(_ path: String, _ value: [String: [NodeRepresentable?]?]?) throws {
        let node = try value.flatMap { try Node(node: $0) }
        self.node[path] = node
    }

    public mutating func set(_ path: String, _ value: [String: [String: NodeRepresentable?]?]?) throws {
        let node = try value.flatMap { try Node(node: $0) }
        self.node[path] = node
    }
}

extension NodeBacked {
    public mutating func set(_ indexers: PathIndexer..., to value: NodeRepresentable?) throws {
        try set(path: indexers, to: value)
    }

    public mutating func set(path indexers: [PathIndexer], to value: NodeRepresentable?) throws {
        let node = try value.flatMap { try Node(node: $0) }
        self.node[indexers] = node
    }

    public mutating func set(_ indexers: PathIndexer..., to value: [NodeRepresentable?]?) throws {
        try set(path: indexers, to: value)
    }

    public mutating func set(path indexers: [PathIndexer], to value: [NodeRepresentable?]?) throws {
        let node = try value.flatMap { try Node(node: $0) }
        self.node[indexers] = node
    }

    public mutating func set(_ indexers: PathIndexer..., to value: [[NodeRepresentable?]?]?) throws {
        try set(path: indexers, to: value)
    }

    public mutating func set(path indexers: [PathIndexer], to value: [[NodeRepresentable?]?]?) throws {
        let node = try value.flatMap { try Node(node: $0) }
        self.node[indexers] = node.flatMap(Node.init)
    }

    public mutating func set(_ indexers: PathIndexer..., to value: [[String: NodeRepresentable?]?]?) throws {
        try set(path: indexers, to: value)
    }

    public mutating func set(path indexers: [PathIndexer], to value: [[String: NodeRepresentable?]?]?) throws {
        let node = try value.flatMap { try Node(node: $0) }
        self.node[indexers] = node.flatMap(Node.init)
    }

    public mutating func set(_ indexers: PathIndexer..., to value: [String: NodeRepresentable?]?) throws {
        try set(path: indexers, to: value)
    }

    public mutating func set(path indexers: [PathIndexer], to value: [String: NodeRepresentable?]?) throws {
        let node = try value.flatMap { try Node(node: $0) }
        self.node[indexers] = node
    }

    public mutating func set(_ indexers: PathIndexer..., to value: [String: [NodeRepresentable?]?]?) throws {
        try set(path: indexers, to: value)
    }

    public mutating func set(path indexers: [PathIndexer], to value: [String: [NodeRepresentable?]?]?) throws {
        let node = try value.flatMap { try Node(node: $0) }
        self.node[indexers] = node
    }

    public mutating func set(_ indexers: PathIndexer..., to value: [String: [String: NodeRepresentable?]?]?) throws {
        try set(path: indexers, to: value)
    }

    public mutating func set(path indexers: [PathIndexer], to value: [String: [String: NodeRepresentable?]?]?) throws {
        let node = try value.flatMap { try Node(node: $0) }
        self.node[indexers] = node
    }
}
