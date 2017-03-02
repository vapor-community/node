extension UInt: NodeConvertible {}
extension UInt8: NodeConvertible {}
extension UInt16: NodeConvertible {}
extension UInt32: NodeConvertible {}
extension UInt64: NodeConvertible {}

extension UnsignedInteger {
    public init(node: Node) throws {
        guard let int = node.uint else {
            throw Error.unableToConvert(input: node, expectation: "\(Self.self)", path: [])
        }

        self.init(int.toUIntMax())
    }

    public func makeNode(in context: Context? = nil) -> Node {
        let number = Node.Number(self.toUIntMax())
        return .number(number)
    }
}
