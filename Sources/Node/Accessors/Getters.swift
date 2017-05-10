extension StructuredDataWrapper {
    public func get<T : NodeInitializable>(
        _ indexers: PathIndexer...
        ) throws -> T {
        return try get(indexers)
    }
    
    public func get<T : NodeInitializable>(
        _ indexers: [PathIndexer]
        ) throws -> T {
        do {
            let value = self[indexers] ?? .null
            return try T(node: value)
        } catch let error as NodeError {
            throw error.appendPath(indexers)
        }
    }
}

// MARK: Optional

extension StructuredDataWrapper {
    public func get<T: NodeInitializable>(_ indexers: PathIndexer...) throws -> T? {
        if let value = self[indexers], value.wrapped != .null {
            let item = try T(node: value)
            return .some(item)
        } else {
            return .none
        }
    }
}

// MARK: Array

extension StructuredDataWrapper {
    public func get<T: NodeInitializable>(_ indexers: PathIndexer...) throws -> [T] {
        guard let values = self[indexers]?.array else {
            throw NodeError.unableToConvert(
                input: Node(self[indexers]?.wrapped ?? .null),
                expectation: "Array of \(T.self)",
                path: indexers
            )
        }
        return try values.map { return try  T(node: $0) }
    }
}

extension StructuredDataWrapper {
    public func get<T: NodeInitializable>(_ indexers: PathIndexer...) throws -> [T]? {
        if let values = self[indexers]?.array {
            let nodes = try values.map { return try  T(node: $0) }
            return .some(nodes)
        } else {
            return .none
        }
    }
}

// MARK: Transformers

extension StructuredDataWrapper {
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
