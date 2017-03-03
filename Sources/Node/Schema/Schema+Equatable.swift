extension StructuredData: Equatable {}

public func ==(lhs: StructuredData, rhs: StructuredData) -> Bool {
    switch (lhs, rhs) {
    case (.null, .null):
        return true
    case let (.bool(l), .bool(r)):
        return l == r
    case let (.number(l), .number(r)):
        return l == r
    case let (.string(l), .string(r)):
        return l == r
    case let (.array(l), .array(r)):
        return l == r
    case let (.object(l), .object(r)):
        return l == r
    case let (.bytes(l), .bytes(r)):
        return l == r
    case let (.date(l), .date(r)):
        return l.timeIntervalSince1970 == r.timeIntervalSince1970
    default:
        return false
    }
}
