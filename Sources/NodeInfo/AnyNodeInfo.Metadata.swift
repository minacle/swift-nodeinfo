import Foundation
import JSONValue

extension AnyNodeInfo {

    @dynamicMemberLookup
    public struct Metadata: Sendable {

        fileprivate var container: [String: JSONValue]

        public subscript(dynamicMember key: String) -> JSONValue? {
            get {
                container[key]
            }
            set {
                container[key] = newValue
            }
        }
    }
}

// MARK: - Codable

extension AnyNodeInfo.Metadata: Codable {

    public init(from decoder: Decoder) throws {
        container = try [String: JSONValue].init(from: decoder)
    }

    public func encode(to encoder: Encoder) throws {
        try container.encode(to: encoder)
    }
}

// MARK: -
