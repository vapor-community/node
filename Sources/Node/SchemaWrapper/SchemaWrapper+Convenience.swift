extension SchemaWrapper {
    public init() {
        self.init(schema: .object([:]), in: EmptyNode)
    }

    public init(_ schema: Schema) {
        self.init(schema: schema, in: nil)
    }

    public init(_ context: Context) {
        self.init(schema: Schema(), in: context)
    }

    public init<S: SchemaWrapper>(_ wrapper: S) {
        self.init(schema: wrapper.schema, in: wrapper.context)
    }

    public init(schema: Schema, in context: Context?) {
        self.init(schema: schema, in: context ?? EmptyNode)
    }
}
