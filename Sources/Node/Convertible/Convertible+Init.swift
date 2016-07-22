extension NodeRepresentable {
    /**
     Map the node back to a convertible type

     - parameter type: the type to map to -- can be inferred
     - throws: if mapping fails
     - returns: convertible representation of object
     */
    public func converted<T: NodeInitializable>(
        to type: T.Type = T.self,
        in context: Context = EmptyNode) throws -> T {
        let node = try makeNode()
        return try type.init(with: node, in: context)
    }
}

extension NodeInitializable {
    public init(_ representable: NodeRepresentable, in context: Context = EmptyNode) throws {
        let node = try representable.makeNode()
        try self.init(with: node, in: context)
    }

    public init(_ representable: NodeRepresentable?, in context: Context = EmptyNode) throws {
        let node = try representable?.makeNode() ?? .null
        try self.init(with: node, in: context)
    }
}

// MARK: Non-Homogenous

extension NodeInitializable {
    public init(_ representable: [String: NodeRepresentable], in context: Context = EmptyNode) throws {
        var converted: [String: Node] = [:]

        for (key, val) in representable {
            converted[key] = try Node(val)
        }

        let node = Node.object(converted)
        try self.init(with: node, in: context)
    }

    public init(_ representable: [String: NodeRepresentable?], in context: Context = EmptyNode) throws {
        var converted: [String: Node] = [:]

        for (key, val) in representable {
            converted[key] = try Node(val)
        }

        let node = Node.object(converted)
        try self.init(with: node, in: context)
    }

    public init(_ representable: [NodeRepresentable], in context: Context = EmptyNode) throws {
        var converted: [Node] = []

        for val in representable {
            converted.append(try Node(val))
        }

        let node = Node.array(converted)
        try self.init(with: node, in: context)
    }

    public init(_ representable: [NodeRepresentable?], in context: Context = EmptyNode) throws {
        var converted: [Node] = []

        for val in representable {
            converted.append(try Node(val))
        }

        let node = Node.array(converted)
        try self.init(with: node, in: context)
    }
}

// MARK: Homogenous

extension NodeInitializable {

    // MARK: Arrays

    public init<N: NodeRepresentable>(_ representable: [N], in context: Context = EmptyNode) throws {
        let mapped = try representable.map { try Node($0) }
        let node = Node.array(mapped)
        try self.init(with: node, in: context)
    }

    public init<N: NodeRepresentable>(_ representable: [N?], in context: Context = EmptyNode) throws {
        let mapped = try representable.map { try Node($0) }
        let node = Node.array(mapped)
        try self.init(with: node, in: context)
    }

    // MARK: Dictionaries

    public init<N: NodeRepresentable>(_ representable: [String: N], in context: Context = EmptyNode) throws {
        var object: [String: Node] = [:]
        try representable.forEach { key, representable in
            object[key] = try Node(representable)
        }
        let node = Node.object(object)
        try self.init(with: node, in: context)
    }

    public init<N: NodeRepresentable>(_ representable: [String: N?], in context: Context = EmptyNode) throws {
        var object: [String: Node] = [:]
        try representable.forEach { key, representable in
            object[key] = try Node(representable)
        }
        let node = Node.object(object)
        try self.init(with: node, in: context)
    }

}


