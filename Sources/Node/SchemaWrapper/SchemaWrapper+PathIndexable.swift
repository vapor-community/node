extension SchemaWrapper {

    /**
     If self is an array representation, return array
     */
    public var pathIndexableArray: [Self]? {
        return schema.schemaArray?.map { Self(schema: $0, in: context) }
    }

    /**
     If self is an object representation, return object
     */
    public var pathIndexableObject: [String: Self]? {
        guard let o = schema.schemaObject else { return nil }
        var object: [String: Self] = [:]
        o.forEach { key, val in
            object[key] = Self(schema: val, in: context)
        }
        return object
    }

    /**
     Initialize json w/ array
     */
    public init(_ array: [Self]) {
        let schema = array.map { $0.schema }
        let node = Schema.array(schema)

        // take first context to attempt inference, should all be same
        let context = array.lazy.flatMap { $0.context } .first
        self.init(schema: node, in: context)
    }

    /**
     Initialize json w/ object
     */
    public init(_ o: [String: Self]) {
        var object: [String: Schema] = [:]
        for (key, val) in o {
            object[key] = val.schema
        }
        let schema = Schema.object(object)

        // take first context to attempt inference, should all be same
        let context = o.values.lazy.flatMap { $0.context } .first
        self.init(schema: schema, in: context)
    }
}
