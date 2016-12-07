import Foundation

extension Date: NodeConvertible {
    /**
     Turn the Date into a node
     
     - throws: if convertible can not create a Node
     - returns: a node if possible
     */
    public func makeNode(context: Context) throws -> Node {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let string = dateFormatter.string(from:self)
        
        return Node(string)
    }
    
    /**
     Initialize the Date with a node within a context.
     
     Context is an empty protocol to which any type can conform.
     This allows flexibility. for objects that might require access
     to a context outside of the node ecosystem
     */
    public init(node: Node, in context: Context) throws {
        
        switch (node) {
        case .string (let string):
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            guard let date = dateFormatter.date(from: string) else {
                throw NodeError.unableToConvert(node: node, expected: "\(String.self)")
            }
            self = date
            return
        default:
            break
        }
        throw NodeError.unableToConvert(node: node, expected: "\(String.self)")
    }
}
