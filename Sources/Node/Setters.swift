extension SchemaWrapper {
    public mutating func set(_ path: String, _ value: NodeRepresentable?) throws {
        let node = try value.flatMap { try Schema(node: $0) }
        self.schema[path] = node
    }

    public mutating func set(_ path: String, _ value: [NodeRepresentable?]?) throws {
        let node = try value.flatMap { try Schema(node: $0) }
        self.schema[path] = node
    }

    public mutating func set(_ path: String, _ value: [[NodeRepresentable?]?]?) throws {
        let node = try value.flatMap { try Schema(node: $0) }
        self.schema[path] = try node.flatMap { try Schema(node: $0) }
    }

    public mutating func set(_ path: String, _ value: [[String: NodeRepresentable?]?]?) throws {
        let node = try value.flatMap { try Schema(node: $0) }
        self.schema[path] = try node.flatMap { try Schema(node: $0) }
    }

    public mutating func set(_ path: String, _ value: [String: NodeRepresentable?]?) throws {
        let node = try value.flatMap { try Schema(node: $0) }
        self.schema[path] = node
    }

    public mutating func set(_ path: String, _ value: [String: [NodeRepresentable?]?]?) throws {
        let node = try value.flatMap { try Schema(node: $0) }
        self.schema[path] = node
    }

    public mutating func set(_ path: String, _ value: [String: [String: NodeRepresentable?]?]?) throws {
        let node = try value.flatMap { try Schema(node: $0) }
        self.schema[path] = node
    }
}

extension SchemaWrapper {
    public mutating func set(_ indexers: PathIndexer..., to value: NodeRepresentable?) throws {
        try set(path: indexers, to: value)
    }

    public mutating func set(path indexers: [PathIndexer], to value: NodeRepresentable?) throws {
        let node = try value.flatMap { try Schema(node: $0) }
        self.schema[indexers] = node
    }

    public mutating func set(_ indexers: PathIndexer..., to value: [NodeRepresentable?]?) throws {
        try set(path: indexers, to: value)
    }

    public mutating func set(path indexers: [PathIndexer], to value: [NodeRepresentable?]?) throws {
        let node = try value.flatMap { try Schema(node: $0) }
        self.schema[indexers] = node
    }

    public mutating func set(_ indexers: PathIndexer..., to value: [[NodeRepresentable?]?]?) throws {
        try set(path: indexers, to: value)
    }

    public mutating func set(path indexers: [PathIndexer], to value: [[NodeRepresentable?]?]?) throws {
        let node = try value.flatMap { try Schema(node: $0) }
        self.schema[indexers] = try node.flatMap { try Schema(node: $0) }
    }

    public mutating func set(_ indexers: PathIndexer..., to value: [[String: NodeRepresentable?]?]?) throws {
        try set(path: indexers, to: value)
    }

    public mutating func set(path indexers: [PathIndexer], to value: [[String: NodeRepresentable?]?]?) throws {
        let node = try value.flatMap { try Schema(node: $0) }
        self.schema[indexers] = try node.flatMap { try Schema(node: $0) }
    }

    public mutating func set(_ indexers: PathIndexer..., to value: [String: NodeRepresentable?]?) throws {
        try set(path: indexers, to: value)
    }

    public mutating func set(path indexers: [PathIndexer], to value: [String: NodeRepresentable?]?) throws {
        let node = try value.flatMap { try Schema(node: $0) }
        self.schema[indexers] = node
    }

    public mutating func set(_ indexers: PathIndexer..., to value: [String: [NodeRepresentable?]?]?) throws {
        try set(path: indexers, to: value)
    }

    public mutating func set(path indexers: [PathIndexer], to value: [String: [NodeRepresentable?]?]?) throws {
        let node = try value.flatMap { try Schema(node: $0) }
        self.schema[indexers] = node
    }

    public mutating func set(_ indexers: PathIndexer..., to value: [String: [String: NodeRepresentable?]?]?) throws {
        try set(path: indexers, to: value)
    }

    public mutating func set(path indexers: [PathIndexer], to value: [String: [String: NodeRepresentable?]?]?) throws {
        let node = try value.flatMap { try Schema(node: $0) }
        self.schema[indexers] = node
    }
}
