extension Int: NodeConvertible {}
extension Int8: NodeConvertible {}
extension Int16: NodeConvertible {}
extension Int32: NodeConvertible {}
extension Int64: NodeConvertible {}

extension SignedInteger {
    public init(node: Node) throws {
        guard let int = node.int else {
            throw NodeError.unableToConvert(input: node, expectation: "\(Self.self)", path: [])
        }

        self.init(int.toIntMax())
    }

    public func makeNode(in context: Context? = nil) -> Node {
        let number = StructuredData.Number(self.toIntMax())
        return .number(number)
    }
}
