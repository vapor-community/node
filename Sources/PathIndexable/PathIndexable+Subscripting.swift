///  Indexable
///  ["a": [["foo":"bar"]]]
///  Indexer list
///  ["a", 0, "foo"]
///
///  "a"
///  [["foo":"bar"]]
///  [0, "foo"]
///
///  0
///  ["foo":"bar"]
///  ["foo"]
///
///  "foo"
///  "bar"
///  []
///
///  ret bar
extension PathIndexable {
    /// Access via comma separated list of indexers, for example
    /// ["key", 0, "path", "here"
    public subscript(indexers: PathIndexer...) -> Self? {
        get {
            return self[indexers]
        }
        set {
            self[indexers] = newValue
        }
    }

    /// Sometimes we prefer (or require) arrays of indexers
    /// those are accepted here
    public subscript(indexers: [PathIndexer]) -> Self? {
        get {
            let indexers = indexers.unwrap()

            /// if there's a next item, then the corresponding index
            /// for that item needs to access it.
            ///
            /// once nil is found, keep returning nil, indexers don't matter at that point
            return indexers.reduce(self) { nextIndexable, nextIndexer in
                return nextIndexable.flatMap(nextIndexer.get)
            }
        }
        set {
            let indexers = indexers.unwrap()

            guard let currentIndexer = indexers.first else { return }
            var indexersRemaining = indexers
            indexersRemaining.removeFirst()

            if indexersRemaining.isEmpty {
                currentIndexer.set(newValue, to: &self)
            } else {
                var next = self[currentIndexer] ?? currentIndexer.makeEmptyStructureForIndexing() as Self
                next[indexersRemaining] = newValue
                self[currentIndexer] = next
            }
        }
    }
}

extension Sequence where Iterator.Element == PathIndexer {
    /// This is how we allow strings to unwrap themselves into larger keys
    /// if you need to preserve `.` in your keys, use the `DotKey` type
    internal func unwrap() -> [PathIndexer] {
        return flatMap { indexer in indexer.unwrapComponents() }
    }

    public func path() -> String {
        return map { $0.description } .joined(separator: ", ")
    }
}
