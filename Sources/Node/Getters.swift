// MARK: Transforming

extension SchemaWrapper {
    public func get<T, InputType: NodeInitializable>(
        _ indexers: PathIndexer...,
        transform: (InputType) throws -> T
    ) throws -> T {
        return try get(path: indexers, transform: transform)
    }

    public func get<T, InputType: NodeInitializable>(
        path indexers: [PathIndexer],
        transform: (InputType) throws -> T
    ) throws -> T {
        let value = self[indexers] ?? .null
        let input = try InputType(node: value, in: context)
        return try transform(input)
    }
}

// MARK: Non-Optional

extension SchemaWrapper {
    public func get<T : NodeInitializable>(
        _ indexers: PathIndexer...)
        throws -> T {
            return try get(indexers)
    }

    public func get<T : NodeInitializable>(
        _ indexers: [PathIndexer])
        throws -> T {
            let value = self[indexers] ?? .null
            return try T(node: value)
    }
}

extension Dictionary {
    func mapValues<T>(_ mapper: (_ value: Value) throws -> T) rethrows -> Dictionary<Key, T> {
        var mapped: [Key: T] = [:]
        try forEach { key, value in
            mapped[key] = try mapper(value)
        }
        return mapped
    }
}
