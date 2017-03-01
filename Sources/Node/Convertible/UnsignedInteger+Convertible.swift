extension UInt: NodeConvertible {}
extension UInt8: NodeConvertible {}
extension UInt16: NodeConvertible {}
extension UInt32: NodeConvertible {}
extension UInt64: NodeConvertible {}

extension UnsignedInteger {
    public func makeNode(in context: Context = EmptyNode) -> Node {
        let number = Node.Number(self.toUIntMax())
        return .number(number)
    }

    public init(node: Node) throws {
        guard let int = node.uint else {
            throw NodeError(node: node, expectation: "\(Self.self)")
        }

        self.init(int.toUIntMax())
    }
}
