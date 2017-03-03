extension StructuredDataWrapper {
    public mutating func set(_ path: String, _ value: NodeRepresentable?) throws {
        let data = try value.flatMap { try StructuredData(node: $0) }
        self.wrapped[path] = data
    }
}

extension StructuredDataWrapper {
    public mutating func set(_ indexers: PathIndexer..., to value: NodeRepresentable?) throws {
        try set(path: indexers, to: value)
    }

    public mutating func set(path indexers: [PathIndexer], to value: NodeRepresentable?) throws {
        let data = try value.flatMap { try StructuredData(node: $0) }
        self.wrapped[indexers] = data
    }
}
