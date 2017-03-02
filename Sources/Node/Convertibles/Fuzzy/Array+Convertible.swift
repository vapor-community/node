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
        guard Element.self is NodeRepresentable.Type else { throw TypeError.notValid }
        let mapped = try map { $0 as! NodeRepresentable } .map { try $0.makeNode(in: context) }
        return Node(mapped)
    }
}
