extension StructuredDataWrapper {

    /**
     If self is an array representation, return array
     */
    public var pathIndexableArray: [Self]? {
        return wrapped.array?.map { Self($0, in: context) }
    }

    /**
     If self is an object representation, return object
     */
    public var pathIndexableObject: [String: Self]? {
        guard let o = wrapped.object else { return nil }
        var object: [String: Self] = [:]
        o.forEach { key, val in
            object[key] = Self(val, in: context)
        }
        return object
    }

    /**
     Initialize json w/ array
     */
    public init(_ array: [Self]) {
        let schema = array.map { $0.wrapped }
        let node = StructuredData.array(schema)

        // take first context to attempt inference, should all be same
        let context = array.lazy.flatMap { $0.context } .first
        self.init(node, in: context)
    }

    /**
     Initialize json w/ object
     */
    public init(_ o: [String: Self]) {
        var object: [String: StructuredData] = [:]
        for (key, val) in o {
            object[key] = val.wrapped
        }
        let schema = StructuredData.object(object)

        // take first context to attempt inference, should all be same
        #if swift(>=4.1)
        let context = o.values.lazy.compactMap { $0.context } .first
        #else
        let context = o.values.lazy.flatMap { $0.context } .first
        #endif
        self.init(schema, in: context)
    }
}
