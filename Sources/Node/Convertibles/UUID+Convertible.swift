import Foundation

extension UUID: NodeConvertible {
    public init(node: Node) throws {
        guard let string = node.string, let uuid = UUID(uuidString: string) else {
            throw NodeError(node: node, expectation: "\(UUID.self)")
        }
        self = uuid
    }

    public func makeNode(in context: Context? = nil) -> Node {
        return uuidString.makeNode(in: context)
    }
}
