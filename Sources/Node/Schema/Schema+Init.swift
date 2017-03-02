extension SchemaWrapper {
    public init(_ value: Bool) {
        self = .bool(value)
    }

    public init(_ value: String) {
        self = .string(value)
    }

    public init(_ int: Int) {
        self = .number(Schema.Number(int))
    }

    public init(_ double: Double) {
        self = .number(Schema.Number(double))
    }

    public init(_ uint: UInt) {
        self = .number(Schema.Number(uint))
    }

    public init(_ number: Schema.Number) {
        self = .number(number)
    }

    public init(_ value: [Schema]) {
        let array = value.map(Self.init)
        self = .array(array)
    }

    public init(_ value: [String : Schema]) {
        self = Self(.object(value))
    }

    public init(bytes: [UInt8]) {
        self = .bytes(bytes)
    }
}
