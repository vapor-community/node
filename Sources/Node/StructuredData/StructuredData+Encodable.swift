import Foundation

#if swift(>=4.0)
private enum UniversalCodingKey: CodingKey {
    case int(Int)
    case string(String)

    init?(intValue: Int) {
        self = .int(intValue)
    }

    init?(stringValue: String) {
        self = .string(stringValue)
    }

    var intValue: Int? {
        guard case .int(let intValue) = self else {
            return nil
        }

        return intValue
    }

    var stringValue: String {
        switch self {
        case .string(let string):
            return string
        case .int(let int):
            return int.description
        }
    }
}

extension StructuredData: Encodable {
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .array(let array):
            var container = encoder.unkeyedContainer()
            try container.encode(contentsOf: array)
        case .bool(let bool):
            var container = encoder.singleValueContainer()
            try container.encode(bool)
        case .bytes(let bytes):
            var container = encoder.singleValueContainer()
            try container.encode(Data(bytes))
        case .date(let date):
            var container = encoder.singleValueContainer()
            try container.encode(date)
        case .null:
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        case .number(let number):
            var container = encoder.singleValueContainer()

            switch number {
            case .double(let double):
                try container.encode(double)
            case .int(let int):
                try container.encode(int)
            case .uint(let uint):
                try container.encode(uint)
            }
        case .object(let object):
            var container = encoder.container(keyedBy: UniversalCodingKey.self)
            try object.forEach {
                try container.encode($1, forKey: UniversalCodingKey.string($0))
            }
        case .string(let string):
            var container = encoder.singleValueContainer()
            try container.encode(string)
        }
    }
}
#endif
