import Foundation

extension Date: NodeConvertible {
    public func makeNode(context: Context = EmptyNode) throws -> Node {
        return .number(.double(self.timeIntervalSince1970))
    }
    
    public init(node: Node, in context: Context) throws {
        switch node {
        case .number(let number):
            self = Date(timeIntervalSince1970: number.double)
            
        case .string(let dateString):
            if let dateMySQL = dateFormatterMySQL.date(from: dateString) {
                self = dateMySQL
            } else if let dateRFC1123 = dateFormatterRFC1123.date(from: dateString) {
                self = dateRFC1123
            } else {
                throw NodeError.unableToConvert(
                    node: node,
                    expected: "MySQL DATETIME or RFC1123 formatted date."
                )
            }
            
        default:
            throw NodeError.unableToConvert(
                node: node,
                expected: "\(String.self), \(Int.self) or \(Double.self))"
            )
        }
    }
}

// DateFormatter init is slow, need to reuse. Reusing two DateFormatters is
// significantly faster than toggling the formatter's `dateFormat` property.
// On Linux, toggling is actually slower than initializing DateFormatter.
private var _dfMySQL: DateFormatter?
private var dateFormatterMySQL: DateFormatter {
    if let df = _dfMySQL {
        return df
    }
    
    let df = DateFormatter()
    df.timeZone = TimeZone(abbreviation: "UTC")
    df.dateFormat = "yyyy-MM-dd HH:mm:ss"
    _dfMySQL = df
    return df
}

private var _dfRFC1123: DateFormatter?
private var dateFormatterRFC1123: DateFormatter {
    if let df = _dfRFC1123 {
        return df
    }
    
    let df = DateFormatter()
    df.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
    _dfRFC1123 = df
    return df
}
