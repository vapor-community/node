import Foundation

public enum TypeError: Swift.Error {
    case notValid
}

extension Array: NodeConvertible {
    public init(node: Node) throws {
        fatalError()
//        guard let element = Element.self as? NodeInitializable.Type else {
//            throw TypeError.notValid
//        }
//
//        let array = node.typeArray ?? [node]
//        let mapped = try array.map { try element.init(node: $0) }
//        self = mapped as! [Element]
    }

    public func makeNode(in context: Context?) throws -> Node {
        fatalError()
//        guard let representable = self as? [NodeRepresentable] else {
//            throw TypeError.notValid
//        }
//
//        let mapped = try representable.map { try $0.makeNode(in: context) }
//        return Node(mapped)
    }
}
