extension UInt: NodeConvertible {}
extension UInt8: NodeConvertible {}
extension UInt16: NodeConvertible {}
extension UInt32: NodeConvertible {}
extension UInt64: NodeConvertible {}

extension UnsignedInteger {
    public func toNode() throws -> Node {
        let double = Double(UIntMax(self.toUIntMax()))
        return Node(double)
    }

    public init(with node: Node, in context: Context) throws {
        guard let int = node.uint else {
            throw ErrorFactory.unableToConvert(node, to: Self.self)
        }

        self.init(int.toUIntMax())
    }
}
