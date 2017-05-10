extension StructuredData: PathIndexable {
    /// If self is an array representation, return array
    public var pathIndexableArray: [StructuredData]? {
        return array
    }

    /// If self is an object representation, return object
    public var pathIndexableObject: [String: StructuredData]? {
        return object
    }

    public init(_ array: [StructuredData]) {
        self = .array(array)
    }

    public init(_ object: [String: StructuredData]) {
        self = .object(object)
    }
}
