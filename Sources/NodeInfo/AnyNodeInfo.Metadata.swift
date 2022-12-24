import Foundation

extension AnyNodeInfo {

    @dynamicMemberLookup
    public struct Metadata: Sendable {

        fileprivate var container: [String: Value]

        public subscript(dynamicMember key: String) -> Value? {
            get {
                container[key]
            }
            set {
                container[key] = newValue
            }
        }
    }
}

extension AnyNodeInfo.Metadata {

    public enum Value: Equatable, Sendable {

        case `nil`

        case bool(Bool)

        case int64(Int64)

        case float64(Float64)

        case string(String)

        case array(Array)

        case dictionary(Dictionary)
    }
}

extension AnyNodeInfo.Metadata.Value {

    public typealias Array = Swift.Array<Self>

    public typealias Dictionary = Swift.Dictionary<String, Self>
}

// MARK: - Codable

extension AnyNodeInfo.Metadata: Codable {

    public init(from decoder: Decoder) throws {
        container = try [String: Value].init(from: decoder)
    }

    public func encode(to encoder: Encoder) throws {
        try container.encode(to: encoder)
    }
}

extension AnyNodeInfo.Metadata.Value: Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self = .nil
        }
        else if let dictionary = try? container.decode(Dictionary.self) {
            self = .dictionary(dictionary)
        }
        else if let array = try? container.decode(Array.self) {
            self = .array(array)
        }
        else if let string = try? container.decode(String.self) {
            self = .string(string)
        }
        else if let int64 = try? container.decode(Int64.self) {
            self = .int64(int64)
        }
        else if let float64 = try? container.decode(Float64.self) {
            self = .float64(float64)
        }
        else if let bool = try? container.decode(Bool.self) {
            self = .bool(bool)
        }
        else {
            throw DecodingError.typeMismatch(
                Self.self,
                    .init(
                        codingPath: container.codingPath,
                        debugDescription: "Unsupported type of value found."))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .nil:
            try container.encodeNil()
        case .bool(let bool):
            try container.encode(bool)
        case .int64(let int64):
            try container.encode(int64)
        case .float64(let float64):
            try container.encode(float64)
        case .string(let string):
            try container.encode(string)
        case .array(let array):
            try container.encode(array)
        case .dictionary(let dictionary):
            try container.encode(dictionary)
        }
    }
}

// MARK: -

extension Dictionary<String, AnyNodeInfo.Metadata.Value> {

    public init(_ other: AnyNodeInfo.Metadata) {
        self = other.container
    }
}
