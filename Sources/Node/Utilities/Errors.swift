@_exported import Debugging

public enum NodeError: Debuggable {
    case noFuzzyConverter(item: Any?, type: Any.Type)
    case invalidDictionaryKeyType
    case unableToConvert(input: Node?, expectation: String, path: [PathIndexer])
}

extension NodeError {
    func appendPath(_ path: [PathIndexer]) -> NodeError {
        switch self {
        case .unableToConvert(
            input: let input,
            expectation: let expectation,
            path: let existing
        ) where existing.isEmpty:
            return .unableToConvert(input: input, expectation: expectation, path: path)
        default:
            return self
        }
    }
}

extension NodeError {
    public var identifier: String {
        switch self {
        case .noFuzzyConverter:
            return "noFuzzyConverter"
        case .invalidDictionaryKeyType:
            return "invalidDictionaryKeyType"
        case .unableToConvert:
            return "unableToConvert"
        }
    }

    public var reason: String {
        switch self {
        case .noFuzzyConverter(let item, let type):
            let reason: String
            if let item = item {
                reason = "No converters found for \(item) of type \(type)"
            } else {
                reason = "No converters found for type \(type)"
            }
            return reason
        case .invalidDictionaryKeyType:
            return "Dictionary must have String keys."
        case .unableToConvert(let node, let expectation, let path):
            let path = path.map { "\($0)" } .joined(separator: ".")
            if let node = node, node != .null {
                return "Unable to convert '\(node)' to '\(expectation)' for path '\(path)'"
            } else {
                return "No value found at path '\(path)', expected '\(expectation)'"
            }
        }
    }

    public var possibleCauses: [String] {
        switch self {
        case .invalidDictionaryKeyType:
            return [
                "You attempted to parse/serialize an object using a dictionary with non-String keys"
            ]
        case .noFuzzyConverter:
            return [
                "You have not properly set the Node.fuzzy array"
            ]
        case .unableToConvert:
            return [
                "typo in key path",
                "underlying type is not convertible",
                "unexpected '.' being interpreted as path instead of key",
            ]
        }
    }

    public var suggestedFixes: [String] {
        switch self {
        case .invalidDictionaryKeyType:
            return [
                "Change dictionary to [String: *] or Dictionary<String, *>"
            ]
        case .noFuzzyConverter(let item, let type):
            var fixes: [String] = []
            
            Node.fuzzy.forEach { fuzzy in
                if let item = item {
                    fixes.append("Conform \(item) of type \(type) to \(fuzzy)Convertible")
                } else {
                    fixes.append("Conform \(type) to \(fuzzy)Convertible")
                }
            }
            
            return fixes
        case .unableToConvert:
            return [
                "called `get(...)` on a key or key path that does not exist in the data",
                "the data being parsed is missing required values or is incorrectly formatted",
                "found unconvertible data, e.g., got a string of letters when an integer is required",
                "if you have keys containing a '.' that shouldn't be interpreted as a path, use 'DotKey(\"actual.key\")'",
            ]
        }
    }
}
