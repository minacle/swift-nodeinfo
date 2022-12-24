import Foundation

public struct AnyNodeInfo: NodeInfo {

    private static let jsonDecoder: JSONDecoder = .init()

    private static let jsonEncoder: JSONEncoder = .init()

    /// The schema version.
    public var version: NodeInfoVersion

    /// Metadata about server software in use.
    public var software: Software?

    /// The protocols supported on this server.
    public var protocols: Protocols?

    /// The third party sites this server can connect to via their application API.
    public var services: Services?

    /// Whether this server allows open self-registration.
    public var openRegistrations: Bool?

    /// Usage statistics for this server.
    public var usage: Usage?

    /// Free form key value pairs for software specific values. Clients should not rely on any specific key present.
    public var metadata: Metadata?

    public init(
        version: NodeInfoVersion,
        software: Software? = nil,
        protocols: Protocols? = nil,
        services: Services? = nil,
        openRegistrations: Bool? = nil,
        usage: Usage? = nil,
        metadata: Metadata? = nil
    ) {
        self.version = version
        self.software = software
        self.protocols = protocols
        self.services = services
        self.openRegistrations = openRegistrations
        self.usage = usage
        self.metadata = metadata
    }

    // MARK: @_typeEraser

    public init<T>(erasing nodeInfo: T)
    where T: NodeInfo {
        let data = try! Self.jsonEncoder.encode(nodeInfo)
        self = try! Self.jsonDecoder.decode(Self.self, from: data)
    }
}

extension AnyNodeInfo {

    public enum Software: Sendable {

        case `struct`(Struct)
    }

    public enum Protocols: Sendable {

        case set(Set)

        case `struct`(Struct)
    }

    public enum Services: Sendable {

        case `struct`(Struct)
    }

    public enum Usage: Sendable {

        case `struct`(Struct)
    }
}

extension AnyNodeInfo.Software {

    public struct Struct: Codable, Sendable {

        /// The canonical name of this server software.
        public var name: String?

        /// The version of this server software.
        public var version: String?

        /// The url of the source code repository of this server software.
        public var repository: String?

        /// The url of the homepage of this server software.
        public var homepage: String?

        public init(
            name: String? = nil,
            version: String? = nil,
            repository: String? = nil,
            homepage: String? = nil
        ) {
            self.name = name
            self.version = version
            self.repository = repository
            self.homepage = homepage
        }
    }
}

extension AnyNodeInfo.Protocols {

    public typealias Set = Swift.Set<String>

    public struct Struct: Codable, Sendable {

        /// The protocols this server can receive traffic for.
        public var inbound: Inbound?

        /// The protocols this server can generate traffic for.
        public var outbound: Outbound?

        public init(
            inbound: Inbound? = nil,
            outbound: Outbound? = nil
        ) {
            self.inbound = inbound
            self.outbound = outbound
        }
    }
}

extension AnyNodeInfo.Protocols.Struct {

    public typealias Inbound = Set<String>

    public typealias Outbound = Set<String>
}

extension AnyNodeInfo.Services {

    public struct Struct: Codable, Sendable {

        /// The third party sites this server can retrieve messages from for combined display with regular traffic.
        public var inbound: Inbound?

        /// The third party sites this server can publish messages to on the behalf of a user.
        public var outbound: Outbound?

        public init(
            inbound: Inbound? = nil,
            outbound: Outbound? = nil
        ) {
            self.inbound = inbound
            self.outbound = outbound
        }
    }
}

extension AnyNodeInfo.Services.Struct {

    public typealias Inbound = Set<String>

    public typealias Outbound = Set<String>
}

extension AnyNodeInfo.Usage {

    public struct Struct: Codable, Sendable {

        /// statistics about the users of this server.
        public var users: Users?

        /// The amount of posts that were made by users that are registered on this server.
        public var localPosts: Int?

        /// The amount of comments that were made by users that are registered on this server.
        public var localComments: Int?

        public init(
            users: Users? = nil,
            localPosts: Int? = nil,
            localComments: Int? = nil
        ) {
            self.users = users
            self.localPosts = localPosts
            self.localComments = localComments
        }
    }
}

extension AnyNodeInfo.Usage.Struct {

    public enum Users: Sendable {

        case `struct`(Struct)
    }
}

extension AnyNodeInfo.Usage.Struct.Users {

    public struct Struct: Codable, Sendable {

        /// The total amount of on this server registered users.
        public var total: Int?

        /// The amount of users that signed in at least once in the last 180 days.
        public var activeHalfyear: Int?

        /// The amount of users that signed in at least once in the last 30 days.
        public var activeMonth: Int?

        public init(
            total: Int? = nil,
            activeHalfyear: Int? = nil,
            activeMonth: Int? = nil
        ) {
            self.total = total
            self.activeHalfyear = activeHalfyear
            self.activeMonth = activeMonth
        }
    }
}

// MARK: - Codable

extension AnyNodeInfo.Software: Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let `struct` = try? container.decode(Struct.self) {
            self = .struct(`struct`)
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
        case .struct(let `struct`):
            try container.encode(`struct`)
        }
    }
}

extension AnyNodeInfo.Protocols: Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let set = try? container.decode(Set.self) {
            self = .set(set)
        }
        else if let `struct` = try? container.decode(Struct.self) {
            self = .struct(`struct`)
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
        case .set(let set):
            try container.encode(set)
        case .struct(let `struct`):
            try container.encode(`struct`)
        }
    }
}

extension AnyNodeInfo.Services: Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let `struct` = try? container.decode(Struct.self) {
            self = .struct(`struct`)
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
        case .struct(let `struct`):
            try container.encode(`struct`)
        }
    }
}

extension AnyNodeInfo.Usage: Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let `struct` = try? container.decode(Struct.self) {
            self = .struct(`struct`)
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
        case .struct(let `struct`):
            try container.encode(`struct`)
        }
    }
}

extension AnyNodeInfo.Usage.Struct.Users: Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let `struct` = try? container.decode(Struct.self) {
            self = .struct(`struct`)
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
        case .struct(let `struct`):
            try container.encode(`struct`)
        }
    }
}
