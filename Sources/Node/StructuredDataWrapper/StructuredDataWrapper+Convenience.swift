extension StructuredDataWrapper {
    public init<S: StructuredDataWrapper>(_ wrapper: S) {
        self.init(wrapper.wrapped, in: wrapper.context)
    }

    public init(node: StructuredData, in context: Context? = Self.defaultContext) {
        self.init(node, in: context)
    }

    public init(node: NodeRepresentable, in context: Context? = Self.defaultContext) throws {
        let node = try node.makeNode(in: context)
        self.init(node)
    }

    public init(_ context: Context? = Self.defaultContext) {
        self.init(.object([:]), in: context)
    }

    public init(_ wrapped: StructuredData, _ context: Context) {
        self.init(wrapped, in: context)
    }

    public init(_ wrapped: StructuredData) {
        self.init(wrapped, in: Self.defaultContext)
    }

    public func converted<T: StructuredDataWrapper>(to type: T.Type = T.self) -> T {
        return T(wrapped, in: context)
    }

    public func converted<T: NodeInitializable>(to type: T.Type = T.self) throws -> T {
        return try T.init(node: self)
    }

}
