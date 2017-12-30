#if swift(>=4.0)
import Foundation

public protocol StructuredDataWrapper:
    NodeConvertible,
    PathIndexable,
    Equatable,
    ExpressibleByNilLiteral,
    ExpressibleByBooleanLiteral,
    ExpressibleByIntegerLiteral,
    ExpressibleByFloatLiteral,
    ExpressibleByStringLiteral,
    ExpressibleByArrayLiteral,
    ExpressibleByDictionaryLiteral,
    Encodable
{
    static var defaultContext: Context? { get }

    var wrapped: StructuredData { get set }
    var context: Context { get }
    init(_ wrapped: StructuredData, in context: Context?)
}

extension StructuredDataWrapper { // : Encodable
    public func encode(to encoder: Encoder) throws {
        try wrapped.encode(to: encoder)
    }
}

#else

public protocol StructuredDataWrapper:
    NodeConvertible,
    PathIndexable,
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
#endif

extension StructuredDataWrapper {
    public static var defaultContext: Context? { return nil }
    public init(node: Node) {
        self.init(node.wrapped, in: node.context)
    }
}
