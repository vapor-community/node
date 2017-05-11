public protocol FuzzyConverter {
    static func represent<T>(
        _ any: T,
        in context: Context
    ) throws -> StructuredData?
    
    static func initialize<T>(
        _ data: StructuredData,
        in context: Context
    ) throws -> T?
}

private var _fuzzyTypes: [FuzzyConverter.Type] = []

extension Node {
    public static var fuzzy: [FuzzyConverter.Type] {
        get { return _fuzzyTypes }
        set { _fuzzyTypes = newValue }
    }
}

extension Array where Iterator.Element == FuzzyConverter.Type {
    func initialize<T>(_ data: StructuredData, in context: Context) throws -> T {
        var maybe: T?
        for fuzzy in Node.fuzzy {
            if let any: T = try fuzzy.initialize(data, in: context) {
                maybe = any
            }
        }
        
        guard let wrapped = maybe else {
            throw NodeError.noFuzzyConverter(item: nil, type: T.self)
        }
        
        return wrapped
    }
    
    func represent<T>(_ any: T, in context: Context?) throws -> StructuredData {
        var maybe: StructuredData?
        for fuzzy in Node.fuzzy {
            if let data = try fuzzy.represent(any, in: context ?? Node.defaultContext) {
                maybe = data
            }
        }
        
        guard let data = maybe else {
            throw NodeError.noFuzzyConverter(item: any, type: T.self)
        }
        return data
    }
}
