/**
     Sometimes convertible operations require a greater context beyond
     just a Node.

     Any object can conform to Context and be included in initialization
*/
public protocol Context {}

public final class ObjectContext<K: Hashable, V>: Context {
    public let object: [K: V]
    public init(_ object: [K: V]) {
        self.object = object
    }
}

public let emptyContext = ObjectContext<String, Int>([:])
