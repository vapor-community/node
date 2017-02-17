import Foundation

extension Date: NodeConvertible {
    public func makeNode(context: Context = EmptyNode) -> Node {
        return .date(self)
    }
    
    public init(node: Node, in context: Context) throws {
        if let string = node.string, let date = Date.iso8601Formatter.date(from: string) {
            self = date
        } else if let date = node.date {
            self = date
        } else{
            throw NodeError.unableToConvert(node: node, expected: "\(Date.self)")
        }
    }
}

extension Date {
    static let iso8601Formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
    var iso8601: String {
        return Date.iso8601Formatter.string(from: self)
    }
}
