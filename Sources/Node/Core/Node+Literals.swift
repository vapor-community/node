extension Node: NilLiteralConvertible {
    public init(nilLiteral value: Void) {
        self = .null
    }
}

extension Node: BooleanLiteralConvertible {
    public init(booleanLiteral value: BooleanLiteralType) {
        self.init(value)
    }
}

extension Node: IntegerLiteralConvertible {
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(value)
    }
}

extension Node: FloatLiteralConvertible {
    public init(floatLiteral value: FloatLiteralType) {
        self.init(value)
    }
}

extension Node: StringLiteralConvertible {
    public init(unicodeScalarLiteral value: String) {
        self.init(value)
    }

    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(value)
    }

    public init(stringLiteral value: String) {
        self.init(value)
    }
}

extension Node: ArrayLiteralConvertible {
    public init(arrayLiteral elements: Node...) {
        self = .array(elements)
    }
}

extension Node: DictionaryLiteralConvertible {
    public init(dictionaryLiteral elements: (String, Node)...) {
        var object = [String : Node](minimumCapacity: elements.count)
        elements.forEach { key, value in
            object[key] = value
        }
        self = .object(object)
    }
}
