// MARK: Transforming

extension SchemaWrapper {
    public func get<T, InputType: NodeInitializable>(
        _ indexers: PathIndexer...,
        transform: (InputType) throws -> T)
        throws -> T {
            return try get(path: indexers, transform: transform)
    }

    public func get<T, InputType: NodeInitializable>(
        path indexers: [PathIndexer],
        transform: (InputType) throws -> T)
        throws -> T {
            guard let _ = self[indexers] else { fatalError() }

            guard let value = schema[indexers] else {
                throw NodeError(node: nil, expectation: "\(T.self)", indexers: indexers)
            }

            let input = try InputType(node: value, in: context)
            return try transform(input)
    }

    public func get<T, InputType: NodeInitializable>(
        _ indexers: PathIndexer...,
        transform: (InputType?) throws -> T)
        throws -> T {
            return try get(path: indexers, transform: transform)
    }

    public func get<T, InputType: NodeInitializable>(
        path indexers: [PathIndexer],
        transform: (InputType?) throws -> T)
        throws -> T {
            return try transform(get(indexers))
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
            guard let value = self[indexers] else {
                throw NodeError(node: nil, expectation: "\(T.self)", indexers: indexers)
            }

            let node = Node(value)
            return try T(node: node)
    }

    public func get<T : NodeInitializable>(
        _ indexers: PathIndexer...)
        throws -> [T] {
            return try get(indexers)
    }

    public func get<T : NodeInitializable>(
        _ indexers: [PathIndexer])
        throws -> [T] {
            guard let value = self[indexers] else {
                throw NodeError(node: nil, expectation: "\([T].self)", indexers: indexers)
            }

            return try [T](node: value)
    }

    public func get<T : NodeInitializable>(
        _ indexers: PathIndexer...)
        throws -> [[T]] {
            return try get(indexers)
    }

    public func get<T : NodeInitializable>(
        _ indexers: [PathIndexer])
        throws -> [[T]] {
            guard let initial = schema[indexers] else {
                throw NodeError(node: nil, expectation: "\([[T]].self)", indexers: indexers)
            }
            let array = initial.schemaArray ?? [initial]
            return try array.map { try [T](node: $0) }
    }

    public func get<T : NodeInitializable>(
        _ indexers: PathIndexer...)
        throws -> [String : T] {
            return try get(indexers)
    }

    public func get<T : NodeInitializable>(
        _ indexers: [PathIndexer])
        throws -> [String : T] {
            let value = schema[indexers]
            guard let object = value?.schemaObject else {
                throw NodeError(node: value, expectation: "\([String: T].self)", indexers: indexers)
            }
            return try object.mapValues { return try T(node: $0) }
    }

    public func get<T : NodeInitializable>(
        _ indexers: PathIndexer...)
        throws -> [String : [T]] {
            return try get(indexers)
    }

    public func get<T : NodeInitializable>(
        _ indexers: [PathIndexer])
        throws -> [String : [T]] {
            let value = schema[indexers]
            guard let object = value?.schemaObject else {
                throw NodeError(node: value, expectation: "\([String: [T]].self)", indexers: indexers)
            }
            return try object.mapValues { return try [T](node: $0) }
    }

    public func get<T : NodeInitializable>(
        _ indexers: PathIndexer...)
        throws -> Set<T> {
            return try get(indexers)
    }

    public func get<T : NodeInitializable>(
        _ indexers: [PathIndexer])
        throws -> Set<T> {
            guard let value = schema[indexers] else {
                throw NodeError(node: nil, expectation: "\(Set<T>.self)", indexers: indexers)
            }
            let array = try [T](node: value)
            return Set(array)
    }
}

// MARK: Optional getions

extension SchemaWrapper {
    public func get<T : NodeInitializable>(
        _ indexers: PathIndexer...)
        throws -> T? {
            return try get(indexers)
    }

    public func get<T : NodeInitializable>(
        _  indexers: [PathIndexer])
        throws -> T? {
            guard let node = schema[indexers], node != .null else { return nil }
            return try T(node: node)
    }

    public func get<T : NodeInitializable>(
        _ indexers: PathIndexer...)
        throws -> [T]? {
            return try get(indexers)
    }

    public func get<T : NodeInitializable>(
        _ indexers: [PathIndexer])
        throws -> [T]? {
            guard let node = schema[indexers], node != .null else { return nil }
            return try [T](node: node)
    }

    public func get<T : NodeInitializable>(
        _ indexers: PathIndexer...)
        throws -> [[T]]? {
            return try get(indexers)
    }

    public func get<T : NodeInitializable>(
        _ indexers: [PathIndexer])
        throws -> [[T]]? {
            guard let schema = schema[indexers], schema != .null else { return nil }
            let array = schema.schemaArray ?? [schema]
            return try array.map { try [T](node: $0) }
    }

    public func get<T : NodeInitializable>(
        _ indexers: PathIndexer...)
        throws -> [String : T]? {
            return try get(indexers)
    }

    public func get<T : NodeInitializable>(
        _ indexers: [PathIndexer])
        throws -> [String : T]? {
            guard let node = schema[indexers], node != .null else { return nil }
            guard let object = node.schemaObject else {
                throw NodeError(node: node, expectation: "\([String: T].self)", indexers: indexers)
            }
            return try object.mapValues { return try T(node: $0) }
    }

    public func get<T : NodeInitializable>(
        _ indexers: PathIndexer...)
        throws -> [String : [T]]? {
            return try get(indexers)
    }

    public func get<T : NodeInitializable>(
        _ indexers: [PathIndexer])
        throws -> [String : [T]]? {
            guard let node = schema[indexers], node != .null else { return nil }
            guard let object = node.schemaObject else {
                throw NodeError(node: node, expectation: "\([String: [T]].self)", indexers: indexers)
            }
            return try object.mapValues { return try [T](node: $0) }
    }

    public func get<T : NodeInitializable>(
        _ indexers: PathIndexer...)
        throws -> Set<T>? {
            return try get(indexers)
    }

    public func get<T : NodeInitializable>(
        _ indexers: [PathIndexer])
        throws -> Set<T>? {
            guard let node = schema[indexers], node != .null else { return nil }
            let array = try [T](node: node)
            return Set(array)
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
