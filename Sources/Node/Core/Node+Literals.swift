//extension Schema: ExpressibleByNilLiteral {
//    public init(nilLiteral value: Void) {
//        self = .null
//    }
//}
//
//extension Schema: ExpressibleByBooleanLiteral {
//    public init(booleanLiteral value: BooleanLiteralType) {
//        self.init(value)
//    }
//}
//
//extension Schema: ExpressibleByIntegerLiteral {
//    public init(integerLiteral value: IntegerLiteralType) {
//        fatalError()
////        self = value.makeNode(in: EmptyNode)
//    }
//}
//
//extension Schema: ExpressibleByFloatLiteral {
//    public init(floatLiteral value: FloatLiteralType) {
//        fatalError()
//        //        self = value.makeNode(in: EmptyNode)
//    }
//}
//
//extension Schema: ExpressibleByStringLiteral {
//    public init(unicodeScalarLiteral value: String) {
//        self.init(value)
//    }
//
//    public init(extendedGraphemeClusterLiteral value: String) {
//        self.init(value)
//    }
//
//    public init(stringLiteral value: String) {
//        self.init(value)
//    }
//}
//
//extension Schema: ExpressibleByArrayLiteral {
//    public init(arrayLiteral elements: Schema...) {
//        self = .array(elements)
//    }
//}
//
//extension Schema: ExpressibleByDictionaryLiteral {
//    public init(dictionaryLiteral elements: (String, Schema)...) {
//        var object = [String : Schema](minimumCapacity: elements.count)
//        elements.forEach { key, value in
//            object[key] = value
//        }
//        self = .object(object)
//    }
//}
