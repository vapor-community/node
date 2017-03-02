extension NodeRepresentable {
    /**
     Map the node back to a convertible type

     - parameter type: the type to map to -- can be inferred
     - throws: if mapping fails
     - returns: convertible representation of object
     */
    public func converted<T: NodeInitializable>(
        to type: T.Type = T.self,
        in context: Context? = nil
    ) throws -> T {
        let node = try makeNode(in: context)
        return try type.init(node: node)
    }
}

extension NodeInitializable {
    public init(node representable: NodeRepresentable?, in context: Context? = nil) throws {
        let node = try representable?.makeNode(in: context) ?? Node(schema: .null, in: context)
        try self.init(node: node)
    }

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
            converted?[key] = try Node(node: val, in: context)
        }

        let node = converted.flatMap(Node.init)
        try self.init(node: node, in: context)
    }

    public init(node representable: [String: [NodeRepresentable?]?]?, in context: Context? = nil) throws {
        var converted: [String: Node]? = representable == nil ? nil : [:]

        try representable?.forEach { key, val in
            converted?[key] = try Node(node: val, in: context)
        }

        let node = converted.flatMap(Node.init)
        try self.init(node: node, in: context)
    }

    public init(node representable: [String: [String: NodeRepresentable?]?]?, in context: Context? = nil) throws {
        var converted: [String: Node]? = representable == nil ? nil : [:]

        try representable?.forEach { key, val in
            converted?[key] = try Node(node: val, in: context)
        }

        let node = converted.flatMap(Node.init)
        try self.init(node: node, in: context)
    }
}

public enum ArrayError: Swift.Error {
    case arrayNotInitializable
}

extension Array: NodeInitializable {
    public init(node: Node) throws {
        guard let element = Element.self as? NodeInitializable.Type else {
            // TODO: BETTER ERROR
            throw ArrayError.arrayNotInitializable
        }
        let array = node.typeArray ?? [node]
        let mapped = try array.map { try element.init(node: $0) }
        self = mapped as! [Element]
    }
}

extension Dictionary: NodeInitializable {
    public init(node: Node) throws {
        // TODO: BETTER ERROR
        guard
            let object = node.typeObject,
            Key.self is String.Type,
            let value = Value.self as? NodeInitializable.Type
            else { throw ArrayError.arrayNotInitializable }

        var mapped: [String: NodeInitializable] = [:]
        try object.forEach { key, node in
            mapped[key] = try value.init(node: node)
        }

        self = mapped as! [Key: Value]
    }
}

extension Set: NodeInitializable {
    public init(node: Node) throws {
        guard let element = Element.self as? NodeInitializable.Type else {
            // TODO: BETTER ERROR
            throw ArrayError.arrayNotInitializable
        }
        let array = node.typeArray ?? [node]
        let mapped = try array.map { try element.init(node: $0) }
        let cast = mapped as! [Element]
        self = Set(cast)
    }
}
