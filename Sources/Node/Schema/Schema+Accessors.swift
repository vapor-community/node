extension StructuredData {
    public var structuredArray: [StructuredData]? {
        switch self {
        case let .array(array):
            return array
        default:
            return nil
        }
    }
    
    public var structuredObject: [String: StructuredData]? {
        switch self {
        case let .object(ob):
            return ob
        default:
            return nil
        }
    }
}

extension StructuredDataWrapper {
    public var typeArray: [Self]? {
        return wrapped.structuredArray?.map { Self($0, in: context) }
    }
    
    public var typeObject: [String: Self]? {
        guard let o = wrapped.structuredObject else { return nil }
        var new = [String: Self]()
        o.forEach { key, val in
            new[key] = Self(val, in: context)
        }
        return new
    }
}
