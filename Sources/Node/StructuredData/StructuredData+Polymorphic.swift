import Bits
import Core

extension StructuredData {
    public var string: String? {
        switch self {
        case .bool(let bool):
            return "\(bool)"
        case .number(let number):
            return "\(number)"
        case .string(let string):
            return string
        case .date(let date):
            Date.lock.lock()
            let string = Date.outgoingDateFormatter.string(from: date)
            Date.lock.unlock()
            return string
        case .bytes(let bytes):
            return bytes.makeString()
        default:
            return nil
        }
    }

    public var int: Int? {
        switch self {
        case .string(let string):
            return string.int
        case .number(let number):
            return number.int
        case .bool(let bool):
            return bool ? 1 : 0
        case .date(let date):
            return try? Date.outgoingTimestamp(date).int
        default:
            return nil
        }
    }

    public var uint: UInt? {
        switch self {
        case .string(let string):
            return string.uint
        case .number(let number):
            return number.uint
        case .bool(let bool):
            return bool ? 1 : 0
        case .date(let date):
            return try? Date.outgoingTimestamp(date).uint
        default:
            return nil
        }
    }

    public var double: Double? {
        switch self {
        case .number(let number):
            return number.double
        case .string(let string):
            return string.double
        case .bool(let bool):
            return bool ? 1.0 : 0.0
        case .date(let date):
            return try? Date.outgoingTimestamp(date).double
        default:
            return nil
        }
    }

    public var isNull: Bool {
        switch self {
        case .null:
            return true
        case .string(let string):
            return string.isNull
        default:
            return false
        }
    }

    public var bool: Bool? {
        switch self {
        case .bool(let bool):
            return bool
        case .number(let number):
            return number.bool
        case .string(let string):
            return string.bool
        case .null:
            return false
        default:
            return nil
        }
    }

    public var float: Float? {
        switch self {
        case .number(let number):
            return Float(number.double)
        case .string(let string):
            return string.float
        case .bool(let bool):
            return bool ? 1.0 : 0.0
        case .date(let date):
            let double = try? Date.outgoingTimestamp(date).double
            return double.flatMap { Float($0) }
        default:
            return nil
        }
    }

    public var array: [StructuredData]? {
        guard case let .array(array) = self else { return nil }
        return array
    }

    public var object: [String: StructuredData]? {
        guard case let .object(ob) = self else { return nil }
        return ob
    }

    public var bytes: [UInt8]? {
        switch self {
        case .bytes(let bytes):
            return bytes
        case .string(let string):
            return string.bytes
        default:
            return nil
        }
    }
}
