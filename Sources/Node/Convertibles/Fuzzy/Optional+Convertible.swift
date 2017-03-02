extension Optional: NodeConvertible {
    public init(node: Node) throws {
        fatalError()
//        guard let wrapped = Wrapped.self as? NodeInitializable.Type else {
//            throw TypeError.notValid
//        }
//        guard node != .null else {
//            self = .none
//            return
//        }
//
//        let mapped = try wrapped.init(node: node) as! Wrapped
//        self = .some(mapped)
    }

    public func makeNode(in context: Context?) throws -> Node {
        fatalError()
//        guard let value = self else { return .null }
//        guard let representable = value as? NodeRepresentable else {
//            throw TypeError.notValid
//        }
//        return try representable.makeNode(in: context)
    }
}
