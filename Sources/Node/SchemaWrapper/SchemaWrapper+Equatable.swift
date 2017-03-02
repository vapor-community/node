extension SchemaWrapper {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.schema == rhs.schema
    }
}
