extension StructuredDataWrapper {
    public mutating func set(_ path: String, _ value: NodeRepresentable?) throws {
        let node = try value.flatMap { try $0.makeNode(in: context) }
        self.wrapped[path] = node?.wrapped
    }
}

extension StructuredDataWrapper {
    public mutating func set(_ indexers: PathIndexer..., to value: NodeRepresentable?) throws {
        try set(path: indexers, to: value)
    }

    public mutating func set(path indexers: [PathIndexer], to value: NodeRepresentable?) throws {
        let node = try value.flatMap { try $0.makeNode(in: context) }
        self.wrapped[indexers] = node?.wrapped
    }
}
