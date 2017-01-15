import Foundation

extension Date: NodeConvertible {
    public func makeNode(context: Context = EmptyNode) -> Node {
        return .date(self)
    }
    
    public init(node: Node, in context: Context) throws {
        guard let date = node.date else {
            throw NodeError.unableToConvert(node: node, expected: "\(Date.self)")
        }
        self = date
    }
}
