public enum Node {
    case null
    case bool(Bool)
    case number(Number)
    case string(String)
    case array([Node])
    case object([String : Node])
}

// MARK: Initialization

extension Node {
    public init(_ value: Bool) {
        self = .bool(value)
    }

    public init(_ value: String) {
        self = .string(value)
    }

    public init(_ value: [String : Node]) {
        self = .object(value)
    }

    public init(_ value: [Node]) {
        let array = [Node](value)
        self = .array(array)
    }
}

// MARK: Number Initializers

extension Node {
    public init<I: Integer>(_ value: I) {
        let number = Number(value)
        self = .number(number)
    }

    public init<U: UnsignedInteger>(_ value: U) {
        let number = Number(value)
        self = .number(number)
    }

    public init(_ value: Float) {
        let number = Number(value)
        self = .number(number)
    }

    public init(_ value: Double) {
        let number = Number(value)
        self = .number(number)
    }
}

// MARK: UInt

extension String {
    public var uint: UInt? {
        return UInt(self)
    }
}

extension Node {
    public var uint: UInt? {
        switch self {
        case .string(let string):
            return string.uint
        case .number(let number):
            return number.uint
        case .bool(let bool):
            return bool ? 1 : 0
        default:
            return nil
        }
    }
}

// MARK: Explicit Accessors

extension Node {
    // TODO: Polymorphic conflict. Consider overloadable functions? -- might not even solve underlying functions
    public var nodeArray: [Node]? {
        switch self {
        case let .array(array):
            return array
        case let .string(string):
            return string.array?
                .flatMap { $0.string }
                .map { Node($0) }
        default:
            return nil
        }
    }
    
    public var nodeObject: [String: Node]? {
        switch self {
        case let .object(ob):
            return ob
        default:
            return nil
        }
    }
}
