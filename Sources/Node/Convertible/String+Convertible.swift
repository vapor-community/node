extension String: NodeConvertible {
    public func makeNode() -> Node {
        return .string(self)
    }

    public init(node: Node, in context: Context) throws {
        guard let string = node.string else {
            throw ErrorFactory.unableToConvert(node, to: type(of: self))
        }
        self = string
    }
}
