//
//  Genome
//
//  Created by Logan Wright
//  Copyright © 2016 lowriDevs. All rights reserved.
//
//  MIT
//

// MARK: To Node

extension Sequence where Iterator.Element: NodeConvertible {
    public func toNode() throws -> Node {
        let array = try map { try $0.toNode() }
        return Node(array)
    }
    public func converted<T: NodeConvertible>(to type: T.Type = T.self) throws -> T {
        return try toNode().converted()
    }
}

extension Dictionary where Key: CustomStringConvertible, Value: NodeConvertible {
    public func toNode() throws -> Node {
        var mutable: [String : Node] = [:]
        try self.forEach { key, value in
            mutable["\(key)"] = try value.toNode()
        }
        return .object(mutable)
    }

    public func converted<T: NodeConvertible>(to type: T.Type = T.self) throws -> Node {
        return try toNode().converted()
    }
}
