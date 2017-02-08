import Foundation

extension Date: NodeConvertible {
    public static var incomingTimestamp: (Node.Number) throws -> Date = {
        return Date(timeIntervalSince1970: $0.double)
    }

    public static var outgoingTimestamp: (Date) throws -> Node.Number = {
        return Node.Number($0.timeIntervalSince1970)
    }

    public static var incomingDateFormatters: [DateFormatter] = [
        .iso8601,
        .mysql,
        .rfc1123
    ]

    public static var outgoingDateFormatter: DateFormatter = .iso8601

    public func makeNode(context: Context = EmptyNode) throws -> Node {
        return .date(self)
    }
    
    public init(node: Node, in context: Context) throws {
        switch node {
        case let .date(date):
            self = date
        case let .number(number):
            self = try Date.incomingTimestamp(number)
        case let .string(string):
            guard let date = Date.incomingDateFormatters.lazy.flatMap({ $0.date(from: string) }).first else { fallthrough }
            self = date
        default:
            throw NodeError(node: node, expectation: "\(Date.self), formatted time string, or timestamp", key: nil)
        }
    }
}

extension DateFormatter {
    /**
        ISO8601 Date Formatter -- preferred in JSON

        http://stackoverflow.com/a/28016692/2611971
    */
    public static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}

extension DateFormatter {
    /**
        A date formatter for mysql formatted types
    */
    public static let mysql: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
}

extension DateFormatter {
    /**
        A date formatter conforming to RFC 1123 spec
    */
    public static let rfc1123: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
        return formatter
    }()
}
