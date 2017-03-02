public protocol SchemaWrapper:
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
    var schema: Schema { get set }
    var context: Context { get }
    init(schema: Schema, in context: Context)
}
