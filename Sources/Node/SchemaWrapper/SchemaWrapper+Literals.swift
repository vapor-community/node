
extension StructuredDataWrapper { // : ExpressibleByNilLiteral {
    public init(nilLiteral value: Void) {
        self = Self(.null)
    }
}

extension StructuredDataWrapper { // : ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = .bool(value)
    }
}

extension StructuredDataWrapper { // : ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = .number(.init(value))
    }
}

extension StructuredDataWrapper { // : ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .number(.init(value))
    }
}

extension StructuredDataWrapper { // : ExpressibleByStringLiteral {
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

extension StructuredDataWrapper { // : ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Self...) {
        self = .array(elements)
    }
}

extension StructuredDataWrapper { // : ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (String, Self)...) {
        var new = [String: Self]()
        elements.forEach { key, value in
            new[key] = value
        }
        self = .object(new)
    }
}
