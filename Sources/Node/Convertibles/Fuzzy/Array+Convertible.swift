import Foundation

public enum TypeError: Swift.Error {
    case notValid
}

extension Array: NodeConvertible {
    public init(node: Node) throws {
        guard Element.self is NodeInitializable.Type else { throw TypeError.notValid }
        let element = Element.self as! NodeInitializable.Type
        let array = node.typeArray ?? [node]
        let mapped = try array.map { try element.init(node: $0) as! Element }
        self = mapped
    }

    public func makeNode(in context: Context?) throws -> Node {
        let mapped = try representable() .map { try $0.makeNode(in: context) }
        return Node(mapped)
    }
}

extension Array {
    /// this is a work around to casting limitations on Linux
    fileprivate func representable() throws -> [NodeRepresentable] {
        let mapped = self.flatMap { $0 as? NodeRepresentable }
        guard mapped.count == count else { throw TypeError.notValid }
        return mapped
    }
}
