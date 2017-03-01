extension Schema: PathIndexable {
    /// If self is an array representation, return array
    public var pathIndexableArray: [Schema]? {
        return schemaArray
    }

    /// If self is an object representation, return object
    public var pathIndexableObject: [String: Schema]? {
        return schemaObject
    }
}
