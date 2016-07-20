public protocol NodeConvertibleFloatingPointType: NodeConvertible {
    var doubleValue: Double { get }
    init(_ other: Double)
}

extension Float: NodeConvertibleFloatingPointType {
    public var doubleValue: Double {
        return Double(self)
    }
}

extension Double: NodeConvertibleFloatingPointType {
    public var doubleValue: Double {
        return Double(self)
    }
}

extension NodeConvertibleFloatingPointType {
    public func toNode() throws -> Node {
        return Node(doubleValue)
    }

    public init(with node: Node, in context: Context) throws {
        guard let double = node.double else {
            throw ErrorFactory.unableToConvert(node, to: Self.self)
        }
        self.init(double)
    }
}
