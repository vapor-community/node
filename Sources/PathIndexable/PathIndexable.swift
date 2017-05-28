
/**
 Objects wishing to inherit complex subscripting should implement
 this protocol
 */
public protocol PathIndexable {
    /// If self is an array representation, return array
    var pathIndexableArray: [Self]? { get }

    /// If self is an object representation, return object
    var pathIndexableObject: [String: Self]? { get }

    /**
     Initialize a new object encapsulating an array of Self

     - parameter array: value to encapsulate
     */
    init(_ array: [Self])

    /**
     Initialize a new object encapsulating an object of type [String: Self]

     - parameter object: value to encapsulate
     */
    init(_ object: [String: Self])
}

// MARK: Indexable

/**
 Anything that can be used as subscript access for a Node.
 
 Int and String are supported natively, additional Indexable types
 should only be added after very careful consideration.
 */
public protocol PathIndexer: CustomStringConvertible {
    /**
        Access for 'self' within the given node,
        ie: inverse ov `= node[self]`

        - parameter node: the node to access

        - returns: a value for index of 'self' if exists
    */
    func get<T: PathIndexable>(from indexable: T) -> T?

    /**
        Set given input to a given node for 'self' if possible.
        ie: inverse of `node[0] =`

        - parameter input:  value to set in parent, or `nil` if should remove
        - parameter parent: node to set input in
    */
    func set<T: PathIndexable>(_ input: T?, to parent: inout T)

    /**
         Create an empty structure that can be set with the given type.
         
         ie: 
         - a string will create an empty dictionary to add itself as a value
         - an Int will create an empty array to add itself as a value

         - returns: an empty structure that can be set by Self
    */
    func makeEmptyStructureForIndexing<T: PathIndexable>() -> T

    /// Used to allow turning one component into many when desirable
    func unwrapComponents() -> [PathIndexer]
}

extension PathIndexer {
    public func unwrapComponents() -> [PathIndexer] { return [self] }
}

extension Int: PathIndexer {
    /**
        - see: PathIndex
    */
    public func get<T: PathIndexable>(from indexable: T) -> T? {
        guard let array = indexable.pathIndexableArray else { return nil }
        guard self < array.count else { return nil }
        return array[self]
    }

    /**
        - see: PathIndex
    */
    public func set<T: PathIndexable>(_ input: T?, to parent: inout T) {
        guard let array = parent.pathIndexableArray else { return }
        guard self < array.count else { return }
        
        var mutable = array
        if let new = input {
            mutable[self] = new
        } else {
            mutable.remove(at: self)
        }
        parent = type(of: parent).init(mutable)
    }

    public func makeEmptyStructureForIndexing<T: PathIndexable>() -> T {
        return T([])
    }
}

extension String: PathIndexer {
    /**
        - see: PathIndex
    */
    public func get<T: PathIndexable>(from indexable: T) -> T? {
        if let object = indexable.pathIndexableObject?[self] {
            return object
        } else if let array = indexable.pathIndexableArray {
            // Index takes precedence
            if let idx = Int(self), idx < array.count {
                return array[idx]
            }

            let value = array.flatMap(self.get)
            guard !value.isEmpty else { return nil }
            return type(of: indexable).init(value)
        }

        return nil
    }

    /**
        - see: PathIndex
    */
    public func set<T: PathIndexable>(_ input: T?, to parent: inout T) {
        if let object = parent.pathIndexableObject {
            var mutable = object
            mutable[self] = input
            parent = type(of: parent).init(mutable)
        } else if let array = parent.pathIndexableArray {
            let mapped: [T] = array.map { val in
                var mutable = val
                self.set(input, to: &mutable)
                return mutable
            }
            parent = type(of: parent).init(mapped)
        }
    }


    public func makeEmptyStructureForIndexing<T: PathIndexable>() -> T {
        return T([:])
    }

    public func unwrapComponents() -> [PathIndexer] {
        return characters
            .split(separator: ".")
            .map(String.init)
    }
}

extension String {
    internal func keyPathComponents() -> [String] {
        return characters
            .split(separator: ".")
            .map(String.init)
    }
}

/// Everything in indexable will explode keypaths,
/// for example, "foo.bar" will become "foo", "bar"
/// should you have . nested in your JSON keys, use this class
///
/// ["foo.bar": 2]
///
/// would be accessed
/// data[DotKey("foo.bar")]
/// this will preserve the `.`
public struct DotKey: PathIndexer {
    public let key: String
    public init(_ key: String) {
        self.key = key
    }

    public func get<T: PathIndexable>(from indexable: T) -> T? {
        return key.get(from: indexable)
    }

    public func set<T: PathIndexable>(_ input: T?, to parent: inout T) {
        key.set(input, to: &parent)
    }

    public func makeEmptyStructureForIndexing<T: PathIndexable>() -> T {
        return key.makeEmptyStructureForIndexing()
    }
}

extension DotKey {
    public var description: String {
        return key
    }
}
