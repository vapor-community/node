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
        
        #if swift(>=4)
            self.init(Int64(int))
        #else
            self.init(int.toUIntMax())
        #endif
    }

    public func makeNode(in context: Context?) -> Node {
        #if swift(>=4)
            let max = Int64(self)
        #else
            let max = self.toUIntMax()
        #endif
        let number = StructuredData.Number(max)
        return .number(number, in: context)
    }
}
