extension Schema {
    public var schemaArray: [Schema]? {
        switch self {
        case let .array(array):
            return array
        default:
            return nil
        }
    }
    
    public var schemaObject: [String: Schema]? {
        switch self {
        case let .object(ob):
            return ob
        default:
            return nil
        }
    }
}

extension SchemaWrapper {
    public var typeArray: [Self]? {
        return schema.schemaArray?.map { Self(schema: $0, in: context) }
    }
    
    public var typeObject: [String: Self]? {
        guard let o = schema.schemaObject else { return nil }
        var new = [String: Self]()
        o.forEach { key, val in
            new[key] = Self(schema: val, in: context)
        }
        return new
    }
}
