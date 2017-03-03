public protocol StructuredDataWrapper:
    NodeConvertible,
    PathIndexable,
    Polymorphic,
    Equatable,
    ExpressibleByNilLiteral,
    ExpressibleByBooleanLiteral,
    ExpressibleByIntegerLiteral,
    ExpressibleByFloatLiteral,
    ExpressibleByStringLiteral,
    ExpressibleByArrayLiteral,
    ExpressibleByDictionaryLiteral
{
    static var defaultContext: Context? { get }

    var wrapped: StructuredData { get set }
    var context: Context { get }
    init(_ wrapped: StructuredData, in context: Context?)
}

extension StructuredDataWrapper {
    public static var defaultContext: Context? { return nil }
    public init(node: Node) {
        self.init(node.wrapped, in: node.context)
    }
}
