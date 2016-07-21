extension Node {
    public init(_ value: Bool) {
        self = .bool(value)
    }

    public init(_ value: String) {
        self = .string(value)
    }

    public init(_ int: Int) {
        self = .number(Number(int))
    }

    public init(_ double: Double) {
        self = .number(Number(double))
    }

    public init(_ uint: UInt) {
        self = .number(Number(uint))
    }

    public init(_ number: Number) {
        self = .number(number)
    }

    public init(_ value: [Node]) {
        let array = [Node](value)
        self = .array(array)
    }

    public init(_ value: [String : Node]) {
        self = .object(value)
    }

    public init(bytes: [UInt8]) {
        self = .bytes(bytes)
    }
}

// MARK: Homogenous

extension Node {

    // MARK: Arrays

    public init<N: NodeRepresentable>(_ representable: [N]) throws {
        let mapped = try representable.map { try Node($0) }
        let node = Node.array(mapped)
        self.init(with: node, in: EmptyNode)
    }

    public init<N: NodeRepresentable>(_ representable: [N?]) throws {
        let mapped = try representable.map { try Node($0) }
        let node = Node.array(mapped)
        self.init(with: node, in: EmptyNode)
    }

    // MARK: Dictionaries

    public init<N: NodeRepresentable>(_ representable: [String: N]) throws {
        var object: [String: Node] = [:]
        try representable.forEach { key, representable in
            object[key] = try Node(representable)
        }
        let node = Node.object(object)
        self.init(with: node, in: EmptyNode)
    }

    public init<N: NodeRepresentable>(_ representable: [String: N?]) throws {
        var object: [String: Node] = [:]
        try representable.forEach { key, representable in
            object[key] = try Node(representable)
        }
        let node = Node.object(object)
        self.init(with: node, in: EmptyNode)
    }
}

// MARK: Non-Homogenous

extension Node {

    // MARK: Arrays

    public init(_ representable: [NodeRepresentable]) throws {
        let mapped = try representable.map { try Node($0) }
        self = .array(mapped)
    }

    public init(_ representable: [NodeRepresentable?]) throws {
        let mapped = try representable.map { try Node($0) }
        self = .array(mapped)
    }

    // MARK: Dictionaries

    public init(_ representable: [String: NodeRepresentable]) throws {
        var object: [String: Node] = [:]
        try representable.forEach { key, representable in
            object[key] = try Node(representable)
        }
        self = .object(object)
    }

    public init(_ representable: [String: NodeRepresentable?]) throws {
        var object: [String: Node] = [:]
        try representable.forEach { key, representable in
            object[key] = try Node(representable)
        }
        self = .object(object)
    }
}
