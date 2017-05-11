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

