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
