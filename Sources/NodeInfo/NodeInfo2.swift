/// NodeInfo schema version 2.0.
public struct NodeInfo2<Metadata>: NodeInfo
where Metadata: Codable & Sendable {

    /// The schema version, must be 2.0.
    public let version: NodeInfoVersion = .v2

    /// Metadata about server software in use.
    public var software: Software

    /// The protocols supported on this server.
    public var protocols: Protocols

    /// The third party sites this server can connect to via their application API.
    public var services: Services

    /// Whether this server allows open self-registration.
    public var openRegistrations: Bool

    /// Usage statistics for this server.
    public var usage: Usage

    /// Free form key value pairs for software specific values. Clients should not rely on any specific key present.
    public var metadata: Metadata

    public init(
        software: Software,
        protocols: Protocols,
        services: Services,
        openRegistrations: Bool,
        usage: Usage,
        metadata: Metadata
    ) {
        self.software = software
        self.protocols = protocols
        self.services = services
        self.openRegistrations = openRegistrations
        self.usage = usage
        self.metadata = metadata
    }

    // MARK: NodeInfo

    private enum CodingKeys: CodingKey {

        case version

        case software

        case protocols

        case services

        case openRegistrations

        case usage

        case metadata
    }

    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        let version = try container.decode(NodeInfoVersion.self, forKey: .version)
        guard version == self.version
        else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.version], debugDescription: "version must be \(self.version.rawValue)"))
        }
        self.software = try container.decode(Software.self, forKey: .software)
        self.protocols = try container.decode(Protocols.self, forKey: .protocols)
        self.services = try container.decode(Services.self, forKey: .services)
        self.openRegistrations = try container.decode(Bool.self, forKey: .openRegistrations)
        self.usage = try container.decode(Usage.self, forKey: .usage)
        self.metadata = try container.decode(Metadata.self, forKey: .metadata)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(version, forKey: .version)
        try container.encode(software, forKey: .software)
        try container.encode(protocols, forKey: .protocols)
        try container.encode(services, forKey: .services)
        try container.encode(openRegistrations, forKey: .openRegistrations)
        try container.encode(usage, forKey: .usage)
        try container.encode(metadata, forKey: .metadata)
    }
}

extension NodeInfo2 {

    public struct Software: Codable, Sendable {

        /// The canonical name of this server software.
        public var name: String

        /// The version of this server software.
        public var version: String

        public init(
            name: String,
            version: String
        ) {
            self.name = name
            self.version = version
        }
    }

    public struct Protocols: NodeInfoSetProtocol, _NodeInfoSetProtocol {

        public enum Element: String, Codable, Hashable, Sendable {

            case activitypub

            case buddycloud

            case dfrn

            case diaspora

            case libretree

            case ostatus

            case pumpio

            case tent

            case xmpp

            case zot
        }

        // MARK: _NodeInfoSetProtocol

        internal var _internalSet: Set<Element>

        public init() {
            _internalSet = .init()
        }
    }

    public struct Services: Codable, Sendable {

        /// The third party sites this server can retrieve messages from for combined display with regular traffic.
        public var inbound: Inbound

        /// The third party sites this server can publish messages to on the behalf of a user.
        public var outbound: Outbound

        public init(
            inbound: Inbound,
            outbound: Outbound
        ) {
            self.inbound = inbound
            self.outbound = outbound
        }
    }

    public struct Usage: Codable, Sendable {

        /// statistics about the users of this server.
        public var users: Users

        /// The amount of posts that were made by users that are registered on this server.
        public var localPosts: Int?

        /// The amount of comments that were made by users that are registered on this server.
        public var localComments: Int?

        public init(
            users: Users,
            localPosts: Int? = nil,
            localComments: Int? = nil
        ) {
            self.users = users
            self.localPosts = localPosts
            self.localComments = localComments
        }
    }
}

extension NodeInfo2.Services {

    public struct Inbound: NodeInfoSetProtocol, _NodeInfoSetProtocol {

        // MARK: _NodeInfoSetProtocol

        public enum Element: String, Codable, Hashable, Sendable {

            case atom1_0 = "atom1.0"

            case gnusocial

            case imap

            case pnut

            case pop3

            case pumpio

            case rss2_0 = "rss2.0"

            case twitter
        }

        internal var _internalSet: Set<Element>

        public init() {
            _internalSet = .init()
        }
    }

    public struct Outbound: NodeInfoSetProtocol, _NodeInfoSetProtocol {

        // MARK: _NodeInfoSetProtocol

        public enum Element: String, Codable, Hashable, Sendable {

            case atom1_0 = "atom1.0"

            case blogger

            case buddycloud

            case diaspora

            case dreamwidth

            case drupal

            case facebook

            case friendica

            case gnusocial

            case google

            case insanejournal

            case libretree

            case linkedin

            case livejournal

            case mediagoblin

            case myspace

            case pinterest

            case pnut

            case posterous

            case pumpio

            case redmatrix

            case rss2_0 = "rss2.0"

            case smtp

            case tent

            case tumblr

            case twitter

            case wordpress

            case xmpp
        }

        internal var _internalSet: Set<Element>

        public init() {
            _internalSet = .init()
        }
    }
}

extension NodeInfo2.Usage {

    public struct Users: Codable, Sendable {

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
