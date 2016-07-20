extension Int: NodeConvertible {}
extension Int8: NodeConvertible {}
extension Int16: NodeConvertible {}
extension Int32: NodeConvertible {}
extension Int64: NodeConvertible {}

extension SignedInteger {
    public func toNode() throws -> Node {
        let double = Double(IntMax(self.toIntMax()))
        return Node(double)
    }

    public init(with node: Node, in context: Context) throws {
        guard let int = node.int else {
            throw ErrorFactory.unableToConvert(node, to: Self.self)
        }

        self.init(int.toIntMax())
    }
}
