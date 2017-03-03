extension StructuredDataWrapper {
    public init() {
        self.init(StructuredData(), in: nil)
    }

    public init(_ schema: StructuredData) {
        self.init(schema, in: nil)
    }

    public init(_ context: Context) {
        self.init(StructuredData(), in: context)
    }

    public init<S: StructuredDataWrapper>(_ wrapper: S) {
        self.init(wrapper.wrapped, in: wrapper.context)
    }

    public init(_ data: StructuredData, in context: Context?) {
        let context = context ?? [String: Int]()
        self.init(data, in: context)
    }
}
