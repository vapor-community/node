/**
     Sometimes convertible operations require a greater context beyond
     just a Node for why an operation is being performed.
*/
public final class Context {
    public static var `default` = Context(id: "default")

    public let id: String
    public var storage: [String: Any] = [:]

    public init(id: String) {
        self.id = id
    }

    public func get<T>(_ key: String) -> T? {
        return storage[key] as? T
    }
}

extension Context: ExpressibleByStringLiteral {
    public convenience init(stringLiteral value: String) {
        self.init(id: value)
    }

    public convenience init(unicodeScalarLiteral value: String) {
        self.init(id: value)
    }

    public convenience init(extendedGraphemeClusterLiteral value: String) {
        self.init(id: value)
    }
}

extension Context {
    public convenience init(_ string: String) {
        self.init(id: string)
    }

    public convenience init<V>(id: String = "dictionary", _ dictionary: [String: V]) {
        self.init(id: id)
        dictionary.forEach { k, v in
            storage[k] = v
        }
    }
}
