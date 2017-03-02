extension SchemaWrapper {
    public mutating func set(_ path: String, _ value: NodeRepresentable?) throws {
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
}
