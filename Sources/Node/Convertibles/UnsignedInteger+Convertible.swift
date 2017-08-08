extension UInt: NodeConvertible {}
extension UInt8: NodeConvertible {}
extension UInt16: NodeConvertible {}
extension UInt32: NodeConvertible {}
extension UInt64: NodeConvertible {}

extension UnsignedInteger {
    public init(node: Node) throws {
        guard let int = node.uint else {
            throw NodeError.unableToConvert(input: node, expectation: "\(Self.self)", path: [])
        }

        #if swift(>=4)
        self.init(UInt64(int))
        #else
        self.init(int.toUIntMax())
        #endif
    }

    public func makeNode(in context: Context?) -> Node {
        #if swift(>=4)
            let max = UInt64(self)
        #else
            let max = self.toUIntMax()
        #endif
        let number = Node.Number(max)
        return .number(number, in: context)
    }
}
