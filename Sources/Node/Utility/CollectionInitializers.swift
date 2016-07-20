//
//  Genome
//
//  Created by Logan Wright
//  Copyright © 2016 lowriDevs. All rights reserved.
//
//  MIT
//

// MARK: MappableObject Initialization

public extension Array where Element : NodeConvertible {
    public init<T: NodeConvertible>(with convertible: T, in context: Context = EmptyNode) throws {
        let node = try convertible.toNode()
        let array = node.nodeArray ?? [node]
        try self.init(with: array, in: context)
    }
    
    public init<T: NodeConvertible>(with convertible: [T], in context: Context = EmptyNode) throws {
        let node = try convertible.map { try $0.toNode() }
        self = try node.map { try Element.init(with: $0, in: context) }
    }
}

public extension Set where Element : NodeConvertible {
    public init<T: NodeConvertible>(with convertible: T, in context: Context = EmptyNode) throws {
        let node = try convertible.toNode()
        let array = node.nodeArray ?? [node]
        try self.init(with: array, in: context)
    }
    
    public init<T: NodeConvertible>(with convertible: [T], in context: Context = EmptyNode) throws {
        let nodes = try convertible.map { try $0.toNode() }
        let array = try nodes.map { try Element.init(with: $0, in: context) }
        self.init(array)
    }
}
