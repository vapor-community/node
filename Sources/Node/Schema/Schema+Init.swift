extension StructuredDataWrapper {
    public init(_ value: Bool) {
        self = .bool(value)
    }

    public init(_ value: String) {
        self = .string(value)
    }

    public init(_ int: Int) {
        self = .number(StructuredData.Number(int))
    }

    public init(_ double: Double) {
        self = .number(StructuredData.Number(double))
    }

    public init(_ uint: UInt) {
        self = .number(StructuredData.Number(uint))
    }

    public init(_ number: StructuredData.Number) {
        self = .number(number)
    }

    public init(_ value: [StructuredData]) {
        let array = value.map(Self.init)
        self = .array(array)
    }

    public init(_ value: [String : StructuredData]) {
        self = Self(.object(value))
    }

    public init(bytes: [UInt8]) {
        self = .bytes(bytes)
    }
}
