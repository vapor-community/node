extension Schema {
    public init(_ value: Bool) {
        self = .bool(value)
    }

    public init(_ value: String) {
        self = .string(value)
    }

    public init(_ int: Int) {
        self = .number(Number(int))
    }

    public init(_ double: Double) {
        self = .number(Number(double))
    }

    public init(_ uint: UInt) {
        self = .number(Number(uint))
    }

    public init(_ number: Number) {
        self = .number(number)
    }

    public init(_ value: [Schema]) {
        let array = [Schema](value)
        self = .array(array)
    }

    public init(_ value: [String : Schema]) {
        self = .object(value)
    }

    public init(bytes: [UInt8]) {
        self = .bytes(bytes)
    }

    public init<S: SchemaWrapper>(_ wrapper: S) {
        self = wrapper.schema
    }
}
