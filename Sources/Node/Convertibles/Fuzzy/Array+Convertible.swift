import Foundation

extension Array: NodeConvertible {
    public init(node: Node) throws {
        guard Element.self is NodeInitializable.Type else {
            throw Error.invalidContainer(container: "\(Array.self)", element: "\(Element.self)")
        }

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
        return try self.map {
            guard let representable = $0 as? NodeRepresentable else {
                throw Error.invalidContainer(container: "\(Array.self)", element: "\(String(describing: $0))")
            }
            return representable
        }
    }
}
