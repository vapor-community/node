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

extension Node {
    public init<N: NodeRepresentable>(_ representable: N) throws {
        self = try representable.makeNode()
    }

    public init<N: NodeRepresentable>(_ representable: N?) throws {
        self = try representable?.makeNode() ?? .null
    }

    public init<N: NodeRepresentable>(_ representable: [N?]) throws {
        let mapped = try representable.map { try Node($0) }
        self = .array(mapped)
    }

    public init<N: NodeRepresentable>(_ representable: [String: N?]) throws {
        var node: [String: Node] = [:]
        for (key, representable) in representable {
            node[key] = try Node(representable)
        }
        self = .object(node)
    }
}
