extension Optional: NodeConvertible {
    public init(node: Node) throws {
        guard Wrapped.self is NodeInitializable.Type else {
            throw Error.invalidContainer(container: "\(Optional.self)", element: "\(Wrapped.self)")
        }
        guard node != .null else {
            self = .none
            return
        }

        let wrapped = Wrapped.self as! NodeInitializable.Type
        let mapped = try wrapped.init(node: node) as! Wrapped
        self = .some(mapped)
    }

    public func makeNode(in context: Context?) throws -> Node {
        guard let value = self else { return .null }
        guard let representable = value as? NodeRepresentable else {
            throw Error.invalidContainer(container: "\(Optional.self)", element: "\(String(describing: value))")
        }
        return try representable.makeNode(in: context)
    }
}
