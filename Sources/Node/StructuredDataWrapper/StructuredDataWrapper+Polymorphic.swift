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

    public var float: Float? {
        return wrapped.float
    }

    public var int: Int? {
        return wrapped.int
    }

    public var uint: UInt? {
        return wrapped.uint
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

    public var array: [Self]? {
        return wrapped.array?.map(Self.init)
    }

    public var object: [String: Self]? {
        guard let object = wrapped.object else { return nil }
        var mutable: [String: Self] = [:]
        object.forEach { k, v in
            mutable[k] = Self(v)
        }
        return mutable
    }
}
