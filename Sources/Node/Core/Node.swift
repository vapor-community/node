public struct Node: StructuredDataWrapper {
    public static let defaultContext = emptyContext
    
    public var wrapped: StructuredData
    public var context: Context

    public init(_ wrapped: StructuredData, in context: Context?) {
        self.wrapped = wrapped
        self.context = context ?? emptyContext
    }
}

extension Node: FuzzyConverter {
    public static func represent<T>(_ any: T, in context: Context) throws -> Node? {
        guard let r = any as? NodeRepresentable else {
            return nil
        }
        return try r.makeNode(in: context)
    }
    
    public static func initialize<T>(node: Node) throws -> T? {
        guard let type = T.self as? NodeInitializable.Type else {
            return nil
        }
        
        return try type.init(node: node) as? T
    }
}

extension Node: NodeConvertible {
    public init(node: Node) {
        self = node
    }

    public func makeNode(in context: Context?) -> Node {
        return self
    }
}
