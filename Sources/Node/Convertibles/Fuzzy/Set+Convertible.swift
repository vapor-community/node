extension Set: NodeConvertible {
    public init(node: Node) throws {
        fatalError()
//        let array = try [Element](node: node)
//        self = Set(array)
    }

    public func makeNode(in context: Context?) throws -> Node {
        fatalError()
//        let array = Array(self)
//        return try array.makeNode(in: context)
    }
}
