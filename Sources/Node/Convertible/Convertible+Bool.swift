extension Bool: NodeConvertible {
    public func makeNode() throws -> Node {
        return Node(self)
    }

    public init(with node: Node, in context: Context) throws {
        guard let bool = node.bool else {
            throw ErrorFactory.unableToConvert(node, to: self.dynamicType)
        }
        self = bool
    }
}
