extension Bool: NodeConvertible {
    public func makeNode() -> Node {
        return .bool(self)
    }

    public init(with node: Node, in context: Context) throws {
        switch node {
        case let .bool(bool):
            self = bool
        case let .string(str):
            self = Bool(str)
        case let .number(num):
            self = num.int == 1
        default:
            throw ErrorFactory.unableToConvert(node, to: self.dynamicType)
        }
    }
}
