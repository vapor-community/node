extension StructuredDataWrapper {
    public mutating func removeKey(_ path: String) {
        self.wrapped[path] = nil
    }

    public mutating func removeKey(_ indexers: PathIndexer...) {
        self.wrapped[indexers] = nil
    }

    public mutating func removeKey(_ indexers: [PathIndexer]) {
        self.wrapped[indexers] = nil
    }
}
