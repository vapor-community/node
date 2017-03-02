extension SchemaWrapper {
    public var isNull: Bool {
        return schema.isNull
    }

    public var bool: Bool? {
        return schema.bool
    }

    public var double: Double? {
        return schema.double
    }

    public var int: Int? {
        return schema.int
    }

    public var string: String? {
        return schema.string
    }

    public var bytes: [UInt8]? {
        return schema.bytes
    }

    public var date: Date? {
        return schema.date
    }

    public var array: [Polymorphic]? {
        return schema.array
    }

    public var object: [String: Polymorphic]? {
        return schema.object
    }
}
