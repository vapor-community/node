extension StructuredDataWrapper {
    public init(_ value: Bool, in context: Context? = Self.defaultContext) {
        self = .bool(value, in: context)
    }

    public init(_ value: String, in context: Context? = Self.defaultContext) {
        self = .string(value, in: context)
    }

    public init(_ int: Int, in context: Context? = Self.defaultContext) {
        self = .number(StructuredData.Number(int), in: context)
    }

    public init(_ double: Double, in context: Context? = Self.defaultContext) {
        self = .number(StructuredData.Number(double), in: context)
    }

    public init(_ uint: UInt, in context: Context? = Self.defaultContext) {
        self = .number(StructuredData.Number(uint), in: context)
    }

    public init(_ number: StructuredData.Number, in context: Context? = Self.defaultContext) {
        self = .number(number, in: context)
    }

    public init(_ value: [StructuredData], in context: Context? = Self.defaultContext) {
        let array = StructuredData.array(value)
        self.init(array, in: context)
    }

    public init(_ value: [String : StructuredData], in context: Context? = Self.defaultContext) {
        self = Self(.object(value), in: context)
    }

    public init(bytes: [UInt8], in context: Context? = Self.defaultContext) {
        self = .bytes(bytes, in: context)
    }
}
