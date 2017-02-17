extension NodeBacked {
    public mutating func set(_ path: String, _ value: NodeRepresentable?) throws {
        let node = try value?.makeNode()
        self.node[path: path] = node
    }

    public mutating func set(_ path: String, _ value: [NodeRepresentable]?) throws {
        let node = try value?.makeNode()
        self.node[path: path] = node
    }

    public mutating func set(_ path: String, _ value: [[NodeRepresentable]]?) throws {
        let node = try value?.map { try $0.makeNode() }
        self.node[path: path] = node.flatMap(Node.init)
    }

    public mutating func set(_ path: String, _ value: [[String: NodeRepresentable]]?) throws {
        let node = try value?.map { try $0.makeNode() }
        self.node[path: path] = node.flatMap(Node.init)
    }

    public mutating func set(_ path: String, _ value: [String: NodeRepresentable]?) throws {
        let node = try value?.makeNode()
        self.node[path: path] = node
    }

    public mutating func set(_ path: String, _ value: [String: [NodeRepresentable]]?) throws {
        self.node[path: path] = try value.flatMap { value in
            var object: [String: Node] = [:]
            try value.forEach { key, array in
                object[key] = try array.makeNode()
            }
            return try object.makeNode()
        }
    }
}
