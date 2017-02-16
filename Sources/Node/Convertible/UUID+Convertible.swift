import Foundation

extension UUID: NodeConvertible {
    public init(node: Node, in context: Context) throws {
        guard let string = node.string, let uuid = UUID(uuidString: string) else {
            throw NodeError(node: node, expectation: "\(UUID.self)", key: nil)
        }
        self = uuid
    }

    public func makeNode(context: Context) -> Node {
        return uuidString.makeNode()
    }
}
