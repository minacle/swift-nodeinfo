public protocol NodeInfo: Codable, Sendable {

    var version: NodeInfoVersion {get}
}
