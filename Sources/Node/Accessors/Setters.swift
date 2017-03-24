extension StructuredDataWrapper {
    public mutating func set(_ path: String, _ value: NodeRepresentable?) throws {
        let node = try value.flatMap { try $0.makeNode(in: context) } ?? .null
        self.wrapped[path] = node.wrapped
    }
}

extension StructuredDataWrapper {
    public mutating func set(_ indexers: PathIndexer..., to value: NodeRepresentable?) throws {
        try set(path: indexers, to: value)
    }

    public mutating func set(path indexers: [PathIndexer], to value: NodeRepresentable?) throws {
        let node = try value.flatMap { try $0.makeNode(in: context) } ?? .null
        self.wrapped[indexers] = node.wrapped
    }
}

extension StructuredDataWrapper {
    public mutating func removeKey(_ path: String) {
        self.wrapped[path] = nil
    }

    public mutating func removeKey(_ indexers: PathIndexer...) {
        self.wrapped[indexers] = nil
    }

    public mutating func removeKey(_ indexers: [PathIndexer]) {
        self.wrapped[indexers] = nil
    }
}
