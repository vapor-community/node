
extension StructuredDataWrapper { // : ExpressibleByNilLiteral {
    public init(nilLiteral value: Void) {
        self = Self(.null, in: Self.defaultContext)
    }
}

extension StructuredDataWrapper { // : ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = .bool(value, in: Self.defaultContext)
    }
}

extension StructuredDataWrapper { // : ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = .number(.init(value), in: Self.defaultContext)
    }
}

extension StructuredDataWrapper { // : ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .number(.init(value), in: Self.defaultContext)
    }
}

extension StructuredDataWrapper { // : ExpressibleByStringLiteral {
    public init(unicodeScalarLiteral value: String) {
        self = .string(value, in: Self.defaultContext)
    }

    public init(extendedGraphemeClusterLiteral value: String) {
        self = .string(value, in: Self.defaultContext)
    }

    public init(stringLiteral value: String) {
        self = .string(value, in: Self.defaultContext)
    }
}

extension StructuredDataWrapper { // : ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Self...) {
        self = .array(elements, in: Self.defaultContext)
    }
}

extension StructuredDataWrapper { // : ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (String, Self)...) {
        var new = [String: Self]()
        elements.forEach { key, value in
            new[key] = value
        }
        self = .object(new, in: Self.defaultContext)
    }
}
