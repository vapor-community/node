extension StructuredDataWrapper {
    public mutating func set(_ path: String, _ any: Any?) throws {
        let value = try Node.fuzzy.represent(any, in: context)
        wrapped[path] = value.wrapped
    }
    
    public func get<T>(_ path: String) throws -> T {
        let data = wrapped[path] ?? .null
        let node = Node(data, in: context)
        return try Node.fuzzy.initialize(node: node)
    }

    public func get<T>() throws -> T {
        let node = Node(wrapped, in: context)
        return try Node.fuzzy.initialize(node: node)
    }
}
