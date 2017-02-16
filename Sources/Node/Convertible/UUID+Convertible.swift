import Foundation

extension UUID: NodeConvertible {
    init(node: Node, in context: Context) throws {
        guard let string = node.string, let uuid = UUID(uuidString: string) else {
            throw NodeError(node: node, expectation: "\(UUID.self)", key: nil)
        }
        self = uuid
    }

    public func makeNode() -> Node {
        return uuidString.makeNode()
    }
}
