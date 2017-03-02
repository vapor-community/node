import Bits

/// This allows schema wrappers to function a bit more like Schema
/// slightly like their enum counterparts passing things like
/// `.null` or `.object(foo)`
extension SchemaWrapper {
    public static var null: Self {
        return Self(.null)
    }

    public static func bool(_ val: Bool) -> Self {
        return Self(.bool(val))
    }

    public static func date(_ val: Date) -> Self {
        return Self(.date(val))
    }

    public static func number(_ val: Schema.Number) -> Self {
        return Self(.number(val))
    }

    public static func string(_ val: String) -> Self {
        return Self(.string(val))
    }

    public static func bytes(_ val: Bytes) -> Self {
        return Self(.bytes(val))
    }

    public static func object<S: SchemaWrapper>(_ val: [String: S]) -> Self {
        var new = [String: Schema]()
        val.forEach { key, value in
            new[key] = value.schema
        }

        return Self(schema: .object(new), in: val.values.first?.context) // context should be same for all
    }

    public static func object(_ val: [String: Self]) -> Self {
        var new = [String: Schema]()
        val.forEach { key, value in
            new[key] = value.schema
        }

        return Self(schema: .object(new), in: val.values.first?.context) // context should be same for all
    }

    public static func array<S: SchemaWrapper>(_ val: [S]) -> Self {
        let new = val.map { $0.schema }
        return Self(schema: .array(new), in: val.first?.context) // context should be same for all
    }

    public static func array(_ val: [Self]) -> Self {
        let new = val.map { $0.schema }
        return Self(schema: .array(new), in: val.first?.context) // context should be same for all
    }
}
