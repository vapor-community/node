// MARK: Node

extension Node {
    /**
     Map the node back to a convertible type

     - parameter type: the type to map to -- can be inferred

     - throws: if mapping fails

     - returns: convertible representation of object
     */
    public func converted<T: NodeRepresentable>(to type: T.Type = T.self) throws -> T {
        return try type.init(with: self, in: self)
    }
}

// MARK: NodeRepresentable

extension NodeRepresentable {
    /**
     Used to initialize a convertible from another node convertible. 
     Usually a backing data type ie: Json, yml, CSV, etc.

     - parameter data:    representation to be converted
     - parameter context: context within to init

     - throws: if mapping fails
     */
    public init<T: NodeRepresentable>(with convertible: T, in context: Context = EmptyNode) throws {
        let node = try convertible.toNode()
        self = try .init(with: node, in: context)
    }

    /**
     Initialize with a backing data dictionary,
     and Foundation context

     - parameter node:    backing data dictionary
     - parameter context: context

     - throws: if fails to initialize
     */
    public init<T: NodeRepresentable>(with convertible: [String : T], in context: Context = EmptyNode) throws {
        var mapped: [String : Node] = [:]
        try convertible.forEach { key, value in
            mapped[key] = try value.toNode()
        }

        let node = Node(mapped)
        try self.init(with: node, in: context)
    }
}
