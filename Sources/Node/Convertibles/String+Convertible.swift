extension String: NodeConvertible {
    public init(node: Node) throws {
        guard let string = node.string else {
            throw NodeError.unableToConvert(input: node, expectation: "\(String.self)", path: [])
        }
        self = string
    }

    public func makeNode(in context: Context?) -> Node {
        return .string(self, in: context)
    }
}
