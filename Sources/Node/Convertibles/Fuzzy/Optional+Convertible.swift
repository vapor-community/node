extension Optional: NodeConvertible {
    public init(node: Node) throws {
        guard Wrapped.self is NodeInitializable.Type else { throw TypeError.notValid }
        guard node != .null else {
            self = .none
            return
        }

        let wrapped = Wrapped.self as! NodeInitializable.Type
        let mapped = try wrapped.init(node: node) as! Wrapped
        self = .some(mapped)
    }

    public func makeNode(in context: Context?) throws -> Node {
        guard Wrapped.self is NodeRepresentable.Type else { throw TypeError.notValid }
        guard let value = self else { return .null }

        let representable = value as! NodeRepresentable
        return try representable.makeNode(in: context)
    }
}
