// MARK: Node

extension Node {
    /**
     Map the node back to a data type

     - parameter type: the type to map to -- can be inferred

     - throws: if mapping fails

     - returns: data representation of object
     */
    public func toData<T: NodeConvertible>(_ type: T.Type = T.self) throws -> T {
        return try type.init(with: self, in: self)
    }
}

// MARK: Node Convertible

extension NodeConvertible {
    /**
     Used to initialize a convertible from another node convertible. 
     Usually a backing data type ie: Json, yml, CSV, etc.

     - parameter data:    representation to be converted
     - parameter context: context within to init

     - throws: if mapping fails
     */
    public init<T: NodeConvertible>(with data: T, in context: Context = EmptyNode) throws {
        let node = try data.toNode()
        self = try .init(with: node, in: context)
    }

    /**
     Initialize with a backing data dictionary,
     and Foundation context

     - parameter node:    backing data dictionary
     - parameter context: context

     - throws: if fails to initialize
     */
    public init<T: NodeConvertible>(with node: [String : T], in context: Context = EmptyNode) throws {
        var mapped: [String : Node] = [:]
        try node.forEach { key, value in
            mapped[key] = try value.toNode()
        }

        let node = Node(mapped)
        try self.init(with: node, in: context)
    }
}
