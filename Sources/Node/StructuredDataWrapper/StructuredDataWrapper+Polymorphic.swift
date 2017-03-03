extension StructuredDataWrapper {
    public var isNull: Bool {
        return wrapped.isNull
    }

    public var bool: Bool? {
        return wrapped.bool
    }

    public var double: Double? {
        return wrapped.double
    }

    public var int: Int? {
        return wrapped.int
    }

    public var string: String? {
        return wrapped.string
    }

    public var bytes: [UInt8]? {
        return wrapped.bytes
    }

    public var date: Date? {
        return wrapped.date
    }

    public var array: [Polymorphic]? {
        return wrapped.array
    }

    public var object: [String: Polymorphic]? {
        return wrapped.object
    }
}
