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

// MARK: Homogenous

extension NodeInitializable {

    // MARK: Arrays

    public init<N: NodeRepresentable>(_ representable: [N]) throws {
        let mapped = try representable.map { try Node($0) }
        let node = Node.array(mapped)
        try self.init(with: node, in: EmptyNode)
    }

    public init<N: NodeRepresentable>(_ representable: [N?]) throws {
        let mapped = try representable.map { try Node($0) }
        let node = Node.array(mapped)
        try self.init(with: node, in: EmptyNode)
    }

    // MARK: Dictionaries 

    public init<N: NodeRepresentable>(_ representable: [String: N]) throws {
        var object: [String: Node] = [:]
        try representable.forEach { key, representable in
            object[key] = try Node(representable)
        }
        let node = Node.object(object)
        try self.init(with: node, in: EmptyNode)
    }

    public init<N: NodeRepresentable>(_ representable: [String: N?]) throws {
        var object: [String: Node] = [:]
        try representable.forEach { key, representable in
            object[key] = try Node(representable)
        }
        let node = Node.object(object)
        try self.init(with: node, in: EmptyNode)
    }
}

// MARK: Non-Homogenous 

extension NodeInitializable {

    // MARK: Individual

    public init(_ representable: NodeRepresentable) throws {
        let node = try representable.makeNode()
        try self.init(with: node, in: EmptyNode)
    }

    public init(_ representable: NodeRepresentable?) throws {
        let node = try representable?.makeNode() ?? .null
        try self.init(with: node, in: EmptyNode)
    }

    // MARK: Arrays

    public init(_ representable: [NodeRepresentable]) throws {
        let mapped = try representable.map { try Node($0) }
        let node = Node.array(mapped)
        try self.init(with: node, in: EmptyNode)
    }

    public init(_ representable: [NodeRepresentable?]) throws {
        let mapped = try representable.map { try Node($0) }
        let node = Node.array(mapped)
        try self.init(with: node, in: EmptyNode)
    }

    // MARK: Dictionaries

    public init(_ representable: [String: NodeRepresentable]) throws {
        var object: [String: Node] = [:]
        try representable.forEach { key, representable in
            object[key] = try Node(representable)
        }
        let node = Node.object(object)
        try self.init(with: node, in: EmptyNode)
    }

    public init(_ representable: [String: NodeRepresentable?]) throws {
        var object: [String: Node] = [:]
        try representable.forEach { key, representable in
            object[key] = try Node(representable)
        }
        let node = Node.object(object)
        try self.init(with: node, in: EmptyNode)
    }
}
