extension Optional: NodeConvertible {
    public init(node: Node) throws {
        guard node != .null else {
            self = .none
            return
        }

        let wrapped: Wrapped = try Node.fuzzy.initialize(
            node.wrapped,
            in: node.context
        )
        self = .some(wrapped)
    }

    public func makeNode(in context: Context?) throws -> Node {
        switch self {
        case .none:
            return .null
        case .some(let some):
            let wrapped = try Node.fuzzy.represent(some, in: context)
            return Node(wrapped, in: context)
        }
    }
}
