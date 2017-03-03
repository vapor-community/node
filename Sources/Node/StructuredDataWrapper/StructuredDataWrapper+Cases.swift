import Bits

/// This allows schema wrappers to function a bit more like StructuredData
/// slightly like their enum counterparts passing things like
/// `.null` or `.object(foo)`
extension StructuredDataWrapper {
    public static var null: Self {
        return Self(.null, in: nil)
    }

    public static func bool(_ val: Bool, in context: Context? = Self.defaultContext) -> Self {
        return Self(.bool(val), in: context)
    }

    public static func date(_ val: Date, in context: Context? = Self.defaultContext) -> Self {
        return Self(.date(val), in: context)
    }

    public static func number(_ val: StructuredData.Number, in context: Context? = Self.defaultContext) -> Self {
        return Self(.number(val), in: context)
    }

    public static func string(_ val: String, in context: Context? = Self.defaultContext) -> Self {
        return Self(.string(val), in: context)
    }

    public static func bytes(_ val: Bytes, in context: Context? = Self.defaultContext) -> Self {
        return Self(.bytes(val), in: context)
    }

    public static func object<S: StructuredDataWrapper>(_ val: [String: S], in context: Context? = Self.defaultContext) -> Self {
        var new = [String: StructuredData]()
        val.forEach { key, value in
            new[key] = value.wrapped
        }

        // context should be same for all
        return Self(.object(new), in: context ?? val.values.first?.context)
    }

    public static func object(_ val: [String: Self], in context: Context? = Self.defaultContext) -> Self {
        var new = [String: StructuredData]()
        val.forEach { key, value in
            new[key] = value.wrapped
        }

        // context should be same for all
        return Self(.object(new), in: context ?? val.values.first?.context)
    }

    public static func array<S: StructuredDataWrapper>(_ val: [S], in context: Context? = Self.defaultContext) -> Self {
        let new = val.map { $0.wrapped }
        // context should be same for all
        return Self(.array(new), in: context ?? val.first?.context)
    }

    public static func array(_ val: [Self], in context: Context? = Self.defaultContext) -> Self {
        let new = val.map { $0.wrapped }
        // context should be same for all
        return Self(.array(new), in: context ?? val.first?.context)
    }
}
