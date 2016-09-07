
extension Dictionary {
    func mapValues<T>(_ mapper: (_ value: Value) throws -> T)
        rethrows -> Dictionary<Key, T> {
        var mapped: [Key: T] = [:]
        try forEach { key, value in
            mapped[key] = try mapper(value)
        }
        return mapped
    }
}

extension Node: NodeBacked {
    public var node: Node {
        get {
            return self
        }
        set {
            self = newValue
        }
    }

    public init(_ node: Node) {
        self = node
    }
}

// MARK: Transforming

extension NodeBacked {
    public func extract<T, InputType: NodeInitializable>(
        _ path: PathIndex...,
        transform: (InputType) throws -> T)
        throws -> T {
            return try extract(path: path, transform: transform)
    }

    public func extract<T, InputType: NodeInitializable>(
        path: [PathIndex],
        transform: (InputType) throws -> T)
        throws -> T {
            guard let value = node[path] else {
                throw NodeError.unableToConvert(node: nil, expected: "\(T.self)")
            }

            let input = try InputType(node: value)
            return try transform(input)
    }

    public func extract<T, InputType: NodeInitializable>(
        _ path: PathIndex...,
        transform: (InputType?) throws -> T)
        throws -> T {
            return try extract(path: path, transform: transform)
    }

    public func extract<T, InputType: NodeInitializable>(
        path: [PathIndex],
        transform: (InputType?) throws -> T)
        throws -> T {
            let value = try node[path].flatMap { try InputType(node: $0) }
            return try transform(value)
    }
}

// MARK: Non-Optional

extension NodeBacked {
    public func extract<T : NodeInitializable>(
        _ path: PathIndex...)
        throws -> T {
            return try extract(path: path)
    }

    public func extract<T : NodeInitializable>(
        path: [PathIndex])
        throws -> T {
            guard let value = node[path] else {
                throw NodeError.unableToConvert(node: nil, expected: "\(T.self)")
            }
            return try T(node: value)
    }

    public func extract<T : NodeInitializable>(
        _ path: PathIndex...)
        throws -> [T] {
            return try extract(path: path)
    }

    public func extract<T : NodeInitializable>(
        path: [PathIndex])
        throws -> [T] {
            let value = node[path] ?? .null
            return try [T](node: value)
    }

    public func extract<T : NodeInitializable>(
        _ path: PathIndex...)
        throws -> [[T]] {
            return try extract(path: path)
    }

    public func extract<T : NodeInitializable>(
        path: [PathIndex])
        throws -> [[T]] {
            guard let initial = node[path] else {
                throw NodeError.unableToConvert(node: nil, expected: "\([[T]].self)")
            }
            let array = initial.nodeArray ?? [initial]
            return try array.map { try [T](node: $0) }
    }

    public func extract<T : NodeInitializable>(
        _ path: PathIndex...)
        throws -> [String : T] {
            return try extract(path: path)
    }

    public func extract<T : NodeInitializable>(
        path: [PathIndex])
        throws -> [String : T] {
            let value = node[path]
            guard let object = value?.nodeObject else {
                throw NodeError.unableToConvert(node: value, expected: "\([String: [T]].self)")
            }
            return try object.mapValues { return try T(node: $0) }
    }

    public func extract<T : NodeInitializable>(
        _ path: PathIndex...)
        throws -> [String : [T]] {
            return try extract(path: path)
    }

    public func extract<T : NodeInitializable>(
        path: [PathIndex])
        throws -> [String : [T]] {
            let value = node[path]
            guard let object = value?.nodeObject else {
                throw NodeError.unableToConvert(node: value, expected: "\([String: [T]].self)")
            }
            return try object.mapValues { return try [T](node: $0) }
    }

    public func extract<T : NodeInitializable>(
        _ path: PathIndex...)
        throws -> Set<T> {
            return try extract(path: path)
    }

    public func extract<T : NodeInitializable>(
        path: [PathIndex])
        throws -> Set<T> {
            guard let value = node[path] else {
                throw NodeError.unableToConvert(node: nil, expected: "\(Set<T>.self)")
            }
            let array = try [T](node: value)
            return Set(array)
    }
}

// MARK: Optional Extractions

extension NodeBacked {
    public func extract<T : NodeInitializable>(
        _ path: PathIndex...)
        throws -> T? {
            return try extract(path: path)
    }

    public func extract<T : NodeInitializable>(
        path: [PathIndex])
        throws -> T? {
            return try node[path].flatMap { try T(node: $0) }
    }

    public func extract<T : NodeInitializable>(
        _ path: PathIndex...)
        throws -> [T]? {
            return try extract(path: path)
    }

    public func extract<T : NodeInitializable>(
        path: [PathIndex])
        throws -> [T]? {
            return try node[path].flatMap { try [T](node: $0) }
    }

    public func extract<T : NodeInitializable>(
        _ path: PathIndex...)
        throws -> [[T]]? {
            return try extract(path: path)
    }

    public func extract<T : NodeInitializable>(
        path: [PathIndex])
        throws -> [[T]]? {
            guard let initial = node[path] else { return nil }
            let array = initial.nodeArray ?? [initial]
            return try array.map { try [T](node: $0) }
    }

    public func extract<T : NodeInitializable>(
        _ path: PathIndex...)
        throws -> [String : T]? {
            return try extract(path: path)
    }

    public func extract<T : NodeInitializable>(
        path: [PathIndex])
        throws -> [String : T]? {
            guard let value = node[path] else { return nil }
            guard let object = value.nodeObject else {
                throw NodeError.unableToConvert(node: value, expected: "\([String: T].self)")
            }
            return try object.mapValues { return try T(node: $0) }
    }

    public func extract<T : NodeInitializable>(
        _ path: PathIndex...)
        throws -> [String : [T]]? {
            return try extract(path: path)
    }

    public func extract<T : NodeInitializable>(
        path: [PathIndex])
        throws -> [String : [T]]? {
            guard let value = node[path] else { return nil }
            guard let object = value.nodeObject else {
                throw NodeError.unableToConvert(node: value, expected: "\([String: T].self)")
            }
            return try object.mapValues { return try [T](node: $0) }
    }

    public func extract<T : NodeInitializable>(
        _ path: PathIndex...)
        throws -> Set<T>? {
            return try extract(path: path)
    }

    public func extract<T : NodeInitializable>(
        path: [PathIndex])
        throws -> Set<T>? {
            return try node[path]
                .flatMap { try [T](node: $0) }
                .flatMap { Set($0) }
    }
}
