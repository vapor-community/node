extension StructuredDataWrapper {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.wrapped == rhs.wrapped
    }
}
