extension Node {
    public init(_ dictionary: [String : NodeRepresentable]) throws {
        var mutable: [String : Node] = [:]
        try dictionary.forEach { key, value in
            mutable[key] = try value.makeNode()
        }
        self = .object(mutable)
    }

    public init<NR: NodeRepresentable>(_ dictionary: [String : NR]) throws {
        var mutable: [String : Node] = [:]
        try dictionary.forEach { key, value in
            mutable[key] = try value.makeNode()
        }
        self = .object(mutable)
    }
}

extension Node {
    // non homogenous
    public init(_ array: [NodeRepresentable]) throws {
        let mapped = try array.map { try $0.makeNode() }
        self = .array(mapped)
    }

    // homogeous
    public init<NR: NodeRepresentable>(_ array: [NR]) throws {
        let mapped = try array.map { try $0.makeNode() }
        self = .array(mapped)
    }
}
