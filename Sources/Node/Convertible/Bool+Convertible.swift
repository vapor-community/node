extension Bool: NodeConvertible {
    public func makeNode() -> Node {
        return .bool(self)
    }

    public init(node: Node, in context: Context) throws {
        guard let bool = node.bool else {
            throw ErrorFactory.unableToConvert(node, to: self.dynamicType)
        }
        self = bool
    }
}
