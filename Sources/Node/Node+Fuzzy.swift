import Foundation

//extension SchemaWrapper {
//    public init(node: Any, in context: Context?) throws {
//        let schema = try Schema(any: node)
//        self.init(schema: schema, in: context)
//    }
//}
//
//extension String: Swift.Error {}
//extension Schema {
//    /**
//     Attempt to initialize a node with a foundation object.
//
//     - warning: will default to null if unexpected value
//     - parameter any: the object to create a node from
//     - throws: if fails to create node.
//     */
//    public init(any: Any) throws {
//        switch any {
//            // If we're coming from foundation, it will be an `NSNumber`.
//        //This represents double, integer, and boolean.
//        case let number as Double:
//            // When coming from ObjC Any, this will represent all Integer types and boolean
//            self = .number(Node.Number(number))
//        // Here to catch 'Any' type, but MUST come AFTER 'Double' check for JSON fuzziness
//        case let bool as Bool:
//            self = .bool(bool)
//        case let int as Int:
//            self = .number(Number(int))
//        case let uint as UInt:
//            self = .number(Number(uint))
//        case let string as String:
//            self = .string(string)
//        case let string as NSString:
//            self = .string(string.description)
//        case let object as [String : Any]:
//            self = try Schema(any: object)
//        case let array as [Any]:
//            self = try Schema(any: array)
//        case _ as NSNull:
//            self = .null
//        case let bytes as Data:
//            let raw = [UInt8](bytes)
//            self = .bytes(raw)
//        case let bytes as NSData:
//            var raw = [UInt8](repeating: 0, count: bytes.length)
//            bytes.getBytes(&raw, length: bytes.length)
//            self = .bytes(raw)
//        case let date as Date:
//            self = .date(date)
//        case let date as NSDate:
//            let date = Date(timeIntervalSince1970: date.timeIntervalSince1970)
//            self = .date(date)
//        case let uuid as UUID:
//            self = .string(uuid.uuidString)
//        case let uuid as NSUUID:
//            self = .string(uuid.uuidString)
//        case let representable as NodeRepresentable:
//            let node = try? representable.makeNode()
//            self = node?.schema ?? .null
//        default:
//            throw "attempted to create schema from unknown type \(any)"
//        }
//    }
//
//    /**
//     Initialize a node with a foundation dictionary
//     - parameter any: the dictionary to initialize with
//     */
//    public init(any: [String : Any]) throws {
//        var mutable: [String : Schema] = [:]
//        try any.forEach { key, val in
//            mutable[key] = try Schema(any: val)
//        }
//        self = .object(mutable)
//    }
//
//    /**
//     Initialize a node with a foundation array
//     - parameter any: the array to initialize with
//     */
//    public init(any: [Any]) throws {
//        let array = try any.map(Schema.init)
//        self = .array(array)
//    }
//
//    /**
//     Create an any representation of the node,
//     intended for Foundation environments.
//     */
//    public var any: Any {
//        switch self {
//        case .object(let ob):
//            var mapped: [String : Any] = [:]
//            ob.forEach { key, val in
//                mapped[key] = val.any
//            }
//            return mapped
//        case .array(let array):
//            return array.map { $0.any }
//        case .bool(let bool):
//            return bool
//        case .number(let number):
//            return number.double
//        case .string(let string):
//            return string
//        case .null:
//            return NSNull()
//        case .bytes(let bytes):
//            return Data(bytes: bytes)
//        case .date(let date):
//            return date
//        }
//    }
//}

public enum ArrayError: Swift.Error {
    case arrayNotInitializable
}

extension Array: NodeConvertible {
    public init(node: Node) throws {
        guard let element = Element.self as? NodeInitializable.Type else {
            // TODO: BETTER ERROR
            throw ArrayError.arrayNotInitializable
        }
        let array = node.typeArray ?? [node]
        let mapped = try array.map { try element.init(node: $0) }
        self = mapped as! [Element]
    }

    public func makeNode(in context: Context?) throws -> Node {
        guard let representable = self as? [NodeRepresentable] else {
            // TODO: BETTER ERROR
            throw ArrayError.arrayNotInitializable
        }

        let mapped = try representable.map { try $0.makeNode(in: context) }
        return Node(mapped)
    }
}

extension Dictionary: NodeConvertible {
    public init(node: Node) throws {
        // TODO: BETTER ERROR
        guard
            let object = node.typeObject,
            Key.self is String.Type,
            let value = Value.self as? NodeInitializable.Type
            else { throw ArrayError.arrayNotInitializable }

        var mapped: [String: NodeInitializable] = [:]
        try object.forEach { key, node in
            mapped[key] = try value.init(node: node)
        }

        self = mapped as! [Key: Value]
    }

    public func makeNode(in context: Context?) throws -> Node {
        guard let representable = self as? [String: NodeRepresentable] else {
            // TODO: BETTER ERROR
            throw ArrayError.arrayNotInitializable
        }

        var mapped: [String: Node] = [:]
        try representable.forEach { key, value in
            mapped[key] = try value.makeNode(in: context)
        }
        return Node(mapped)
    }
}

extension Set: NodeConvertible {
    public init(node: Node) throws {
        let array = try [Element](node: node)
        self = Set(array)
    }

    public func makeNode(in context: Context?) throws -> Node {
        let array = Array(self)
        return try array.makeNode(in: context)
    }
}

extension Optional: NodeConvertible {
    public init(node: Node) throws {
        guard let wrapped = Wrapped.self as? NodeInitializable.Type else { throw ArrayError.arrayNotInitializable }
        guard node != .null else {
            self = .none
            return
        }

        let mapped = try wrapped.init(node: node) as! Wrapped
        self = .some(mapped)
    }

    public func makeNode(in context: Context?) throws -> Node {
        guard let value = self else { return .null }
        guard let representable = value as? NodeRepresentable else { throw ArrayError.arrayNotInitializable }
        return try representable.makeNode(in: context)
    }
}
