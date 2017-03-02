
extension SchemaWrapper { // : ExpressibleByNilLiteral {
    public init(nilLiteral value: Void) {
        self = Self(.null)
    }
}

extension SchemaWrapper { // : ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = .bool(value)
    }
}

extension SchemaWrapper { // : ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = .number(.init(value))
    }
}

extension SchemaWrapper { // : ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .number(.init(value))
    }
}

extension SchemaWrapper { // : ExpressibleByStringLiteral {
    public init(unicodeScalarLiteral value: String) {
        self = .string(value)
    }

    public init(extendedGraphemeClusterLiteral value: String) {
        self = .string(value)
    }

    public init(stringLiteral value: String) {
        self = .string(value)
    }
}

extension SchemaWrapper { // : ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Self...) {
        self = .array(elements)
    }
}

extension SchemaWrapper { // : ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (String, Self)...) {
        var new = [String: Self]()
        elements.forEach { key, value in
            new[key] = value
        }
        self = .object(new)
    }
}
