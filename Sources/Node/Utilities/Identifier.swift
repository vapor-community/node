/// Represents a convenience around various identifier types.
public struct Identifier: StructuredDataWrapper {
    public var wrapped: StructuredData
    public let context: Context

    public init(_ wrapped: StructuredData, in context: Context?) {
        self.wrapped = wrapped
        self.context = context ?? emptyContext
    }
}
