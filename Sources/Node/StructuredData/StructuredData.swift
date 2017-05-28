@_exported import struct Foundation.Date


/// StructuredData is meant a data structure that can be used to facilitate different
/// structured data formats
public enum StructuredData {
    case null
    case bool(Bool)
    case number(Number)
    case string(String)
    case array([StructuredData])
    case object([String: StructuredData])
    case bytes([UInt8])
    case date(Date)
}

extension StructuredData {
    public init() {
        self.init([:])
    }
}

extension StructuredData: CustomStringConvertible {
    public var description: String {
        switch self {
        case .null:
            return "null"
        case .bool(let bool):
            return bool.description
        case .number(let number):
            return number.description
        case .string(let string):
            return string.description
        case .array(let array):
            let string = array.map { $0.description } .joined(separator: ", ")
            return "[\(string)]"
        case .object(let ob):
            let string =  ob.map { key, value in "\(key): \(value)" } .joined(separator: ", ")
            return "[\(string)]"
        case .bytes(let bytes):
            return "\(bytes)"
        case .date(let date):
            return "\(date)"
        }
    }
}
