import Foundation

public enum TypeError: Swift.Error {
    case notValid
}

extension Array: NodeConvertible {
    public init(node: Node) throws {
        guard let element = Element.self as? NodeInitializable.Type else {
            throw TypeError.notValid
        }

        let array = node.typeArray ?? [node]
        let mapped = try array.map { try element.init(node: $0) }
        self = mapped as! [Element]
    }

    public func makeNode(in context: Context?) throws -> Node {
        guard let representable = self as? [NodeRepresentable] else {
            throw TypeError.notValid
        }

        let mapped = try representable.map { try $0.makeNode(in: context) }
        return Node(mapped)
    }
}

extension Dictionary: NodeConvertible {
    public init(node: Node) throws {
        // TODO: BETTER ERROR
        guard
            let object = node.typeObject,
            Key.self is String.Type,
            let value = Value.self as? NodeInitializable.Type
            else { throw TypeError.notValid }

        var mapped: [String: NodeInitializable] = [:]
        try object.forEach { key, node in
            mapped[key] = try value.init(node: node)
        }
        self = mapped as! [Key: Value]
    }

    public func makeNode(in context: Context?) throws -> Node {
        guard let representable = self as? [String: NodeRepresentable] else {
            // TODO: BETTER ERROR
            throw TypeError.notValid
        }

        var mapped: [String: Node] = [:]
        try representable.forEach { key, value in
            mapped[key] = try value.makeNode(in: context)
        }
        return Node(mapped)
    }
}

extension Set: NodeConvertible {
    public init(node: Node) throws {
        let array = try [Element](node: node)
        self = Set(array)
    }

    public func makeNode(in context: Context?) throws -> Node {
        let array = Array(self)
        return try array.makeNode(in: context)
    }
}

extension Optional: NodeConvertible {
    public init(node: Node) throws {
        guard let wrapped = Wrapped.self as? NodeInitializable.Type else {
            throw TypeError.notValid
        }
        guard node != .null else {
            self = .none
            return
        }

        let mapped = try wrapped.init(node: node) as! Wrapped
        self = .some(mapped)
    }

    public func makeNode(in context: Context?) throws -> Node {
        guard let value = self else { return .null }
        guard let representable = value as? NodeRepresentable else {
            throw TypeError.notValid
        }
        return try representable.makeNode(in: context)
    }
}
