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
     Genome found `nil` somewhere that it wasn't expecting

     @param [NodeIndexable] the path that was being mapped
     @param String          the type that was being targeted for given path
     */
    case foundNil(path: [NodeIndexable], targeting: String)

    /**
     Genome was unable to convert a given node to the target type

     @param Node            the node that was unable to convert
     @param String          a description of the type Genome was trying to convert to
     @param [NodeIndexable] current path being mapped if applicable
     */
    case unableToConvert(node: Node, targeting: String, path: [NodeIndexable])
}

extension Error {
    internal func appendLastKeyPath(_ lastKeyPath: [NodeIndexable]) -> Error {
        guard
            case let .unableToConvert(node: node,
                                      targeting: targeting,
                                      path: currentPath) = self
            where currentPath.isEmpty
            else { return self }

        let new = Error.unableToConvert(node: node, targeting: targeting, path: lastKeyPath)
        return new.logged()
    }
}

internal struct ErrorFactory {
    static func foundNil<T>(for path: [NodeIndexable], expected: T.Type) -> Error {
        let error = Error.foundNil(path: path,
                                   targeting: "\(T.self)")
        return error.logged()
    }

    static func unableToConvert<T>(_ node: Node,
                                   to type: T.Type) -> Error {
        let error = Error.unableToConvert(node: node,
                                          targeting: "\(type)",
                                          path: [])
        return error.logged()
    }
}
