extension NodeRepresentable {
    /**
     Map the node back to a convertible type

     - parameter type: the type to map to -- can be inferred
     - throws: if mapping fails
     - returns: convertible representation of object
     */
    public func converted<T: NodeInitializable>(
        to type: T.Type = T.self,
        in context: Context? = nil) throws -> T {
        let node = try makeNode(in: context)
        return try type.init(node: node)
    }
}

extension NodeInitializable {
    public init(node representable: NodeRepresentable?, in context: Context? = nil) throws {
        let node = try representable?.makeNode(in: context) ?? .null
        try self.init(node: node)
    }
}

extension NodeInitializable {
    public init(node representable: [NodeRepresentable?]?, in context: Context? = nil) throws {
        var converted: [Node]? = representable == nil ? nil : []

        try representable?.forEach { val in
            converted?.append(try Node(node: val, in: context))
        }

        let node = converted.flatMap(Node.init)
        try self.init(node: node)
    }

    public init(node representable: [[NodeRepresentable?]?]?, in context: Context? = nil) throws {
        let mapped = try representable?.map { try $0.flatMap { try Node(node: $0, in: context) } }
        try self.init(node: mapped, in: context)
    }

    public init(node representable: [[String: NodeRepresentable?]?]?, in context: Context? = nil) throws {
        let mapped = try representable?.map { try $0.flatMap { try Node(node: $0, in: context) } }
        try self.init(node: mapped, in: context)
    }

    public init(node representable: [String: NodeRepresentable?]?, in context: Context? = nil) throws {
        var converted: [String: Node]? = representable == nil ? nil : [:]

        try representable?.forEach { key, val in
            converted?[key] = try Node(node: val)
        }

        let node = converted.flatMap(Node.init)
        try self.init(node: node, in: context)
    }

    public init(node representable: [String: [NodeRepresentable?]?]?, in context: Context? = nil) throws {
        var converted: [String: Node]? = representable == nil ? nil : [:]

        try representable?.forEach { key, val in
            converted?[key] = try Node(node: val)
        }

        let node = converted.flatMap(Node.init)
        try self.init(node: node, in: context)
    }

    public init(node representable: [String: [String: NodeRepresentable?]?]?, in context: Context? = nil) throws {
        var converted: [String: Node]? = representable == nil ? nil : [:]

        try representable?.forEach { key, val in
            converted?[key] = try Node(node: val)
        }

        let node = converted.flatMap(Node.init)
        try self.init(node: node, in: context)
    }
}
