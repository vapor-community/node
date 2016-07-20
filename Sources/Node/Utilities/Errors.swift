//
//  Genome
//
//  Created by Logan Wright
//  Copyright © 2016 lowriDevs. All rights reserved.
//
//  MIT
//

public enum Error: ErrorProtocol {
    /**
     Genome was unable to convert a given node to the target type

     @param Node            the node that was unable to convert
     @param String          a description of the type Genome was trying to convert to
     @param [NodeIndexable] current path being mapped if applicable
     */
    case unableToConvert(node: Node, expected: String)
}

internal struct ErrorFactory {
    static func unableToConvert<T>(_ node: Node,
                                   to type: T.Type) -> Error {
        let error = Error.unableToConvert(node: node,
                                          expected: "\(type)")
        return error
    }
}
