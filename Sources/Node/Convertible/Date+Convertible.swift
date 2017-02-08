import Foundation

extension Date: NodeConvertible {
    public func makeNode(context: Context = EmptyNode) throws -> Node {
        return .date(self)
    }
    
    public init(node: Node, in context: Context) throws {
        guard case let .date(date) = node else {
            throw NodeError(node: node, expectation: "\(Date.self)", key: nil)
        }
        self = date
    }
}
