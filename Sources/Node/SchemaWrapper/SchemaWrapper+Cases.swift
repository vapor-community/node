import Bits

/// This allows schema wrappers to function a bit more like StructuredData
/// slightly like their enum counterparts passing things like
/// `.null` or `.object(foo)`
extension StructuredDataWrapper {
    public static var null: Self {
        return Self(.null)
    }

    public static func bool(_ val: Bool) -> Self {
        return Self(.bool(val))
    }

    public static func date(_ val: Date) -> Self {
        return Self(.date(val))
    }

    public static func number(_ val: StructuredData.Number) -> Self {
        return Self(.number(val))
    }

    public static func string(_ val: String) -> Self {
        return Self(.string(val))
    }

    public static func bytes(_ val: Bytes) -> Self {
        return Self(.bytes(val))
    }

    public static func object<S: StructuredDataWrapper>(_ val: [String: S]) -> Self {
        var new = [String: StructuredData]()
        val.forEach { key, value in
            new[key] = value.wrapped
        }

        return Self(.object(new), in: val.values.first?.context) // context should be same for all
    }

    public static func object(_ val: [String: Self]) -> Self {
        var new = [String: StructuredData]()
        val.forEach { key, value in
            new[key] = value.wrapped
        }

        return Self(.object(new), in: val.values.first?.context) // context should be same for all
    }

    public static func array<S: StructuredDataWrapper>(_ val: [S]) -> Self {
        let new = val.map { $0.wrapped }
        return Self(.array(new), in: val.first?.context) // context should be same for all
    }

    public static func array(_ val: [Self]) -> Self {
        let new = val.map { $0.wrapped }
        return Self(.array(new), in: val.first?.context) // context should be same for all
    }
}
