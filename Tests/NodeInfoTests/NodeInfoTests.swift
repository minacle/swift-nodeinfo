import Foundation
import XCTest

@testable
import NodeInfo

final class NodeInfoTests: XCTestCase {

    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()

    func testNodeInfo1() throws {
        let nodeInfo = try Self.jsonDecoder.decode(NodeInfo1<ExampleMetadata1_0>.self, from: Self.example1_0)
        XCTAssertEqual(nodeInfo.version, .v1)
        XCTAssertEqual(nodeInfo.software.name, .diaspora)
        XCTAssertEqual(nodeInfo.software.version, "0.5.0")
        XCTAssertEqual(nodeInfo.protocols.inbound, [.diaspora])
        XCTAssertEqual(nodeInfo.protocols.outbound, [.diaspora])
        XCTAssertEqual(nodeInfo.services.inbound, [.gnusocial])
        XCTAssertEqual(nodeInfo.services.outbound, [.facebook, .twitter])
        XCTAssertTrue(nodeInfo.openRegistrations)
        XCTAssertEqual(nodeInfo.usage.users.total, 123)
        XCTAssertEqual(nodeInfo.usage.users.activeHalfyear, 42)
        XCTAssertEqual(nodeInfo.usage.users.activeMonth, 23)
        XCTAssertEqual(nodeInfo.usage.localPosts, 500)
        XCTAssertEqual(nodeInfo.usage.localComments, 1000)
        XCTAssertTrue(nodeInfo.metadata.chatEnabled)
    }

    func testNodeInfo1_1() throws {
        let nodeInfo = try Self.jsonDecoder.decode(NodeInfo1_1<ExampleMetadata1_1>.self, from: Self.example1_1)
        XCTAssertEqual(nodeInfo.version, .v1_1)
        XCTAssertEqual(nodeInfo.software.name, .diaspora)
        XCTAssertEqual(nodeInfo.software.version, "0.5.0")
        XCTAssertEqual(nodeInfo.protocols.inbound, [.diaspora])
        XCTAssertEqual(nodeInfo.protocols.outbound, [.diaspora])
        XCTAssertEqual(nodeInfo.services.inbound, [.gnusocial])
        XCTAssertEqual(nodeInfo.services.outbound, [.facebook, .twitter])
        XCTAssertTrue(nodeInfo.openRegistrations)
        XCTAssertEqual(nodeInfo.usage.users.total, 123)
        XCTAssertEqual(nodeInfo.usage.users.activeHalfyear, 42)
        XCTAssertEqual(nodeInfo.usage.users.activeMonth, 23)
        XCTAssertEqual(nodeInfo.usage.localPosts, 500)
        XCTAssertEqual(nodeInfo.usage.localComments, 1000)
        XCTAssertTrue(nodeInfo.metadata.chatEnabled)
    }

    func testNodeInfo2() throws {
        let nodeInfo = try Self.jsonDecoder.decode(NodeInfo2<ExampleMetadata2_0>.self, from: Self.example2_0)
        XCTAssertEqual(nodeInfo.version, .v2)
        XCTAssertEqual(nodeInfo.software.name, "diaspora")
        XCTAssertEqual(nodeInfo.software.version, "0.5.0")
        XCTAssertEqual(nodeInfo.protocols, [.diaspora])
        XCTAssertEqual(nodeInfo.services.inbound, [.gnusocial])
        XCTAssertEqual(nodeInfo.services.outbound, [.facebook, .twitter])
        XCTAssertTrue(nodeInfo.openRegistrations)
        XCTAssertEqual(nodeInfo.usage.users.total, 123)
        XCTAssertEqual(nodeInfo.usage.users.activeHalfyear, 42)
        XCTAssertEqual(nodeInfo.usage.users.activeMonth, 23)
        XCTAssertEqual(nodeInfo.usage.localPosts, 500)
        XCTAssertEqual(nodeInfo.usage.localComments, 1000)
        XCTAssertTrue(nodeInfo.metadata.chatEnabled)
    }

    func testNodeInfo2_1() throws {
        let nodeInfo = try Self.jsonDecoder.decode(NodeInfo2_1<ExampleMetadata2_1>.self, from: Self.example2_1)
        XCTAssertEqual(nodeInfo.version, .v2_1)
        XCTAssertEqual(nodeInfo.software.name, "diaspora")
        XCTAssertEqual(nodeInfo.software.version, "0.5.0")
        XCTAssertEqual(nodeInfo.software.repository, "https://github.com/diaspora/diaspora")
        XCTAssertEqual(nodeInfo.software.homepage, "https://diasporafoundation.org/")
        XCTAssertEqual(nodeInfo.protocols, [.diaspora])
        XCTAssertEqual(nodeInfo.services.inbound, [.gnusocial])
        XCTAssertEqual(nodeInfo.services.outbound, [.facebook, .twitter])
        XCTAssertTrue(nodeInfo.openRegistrations)
        XCTAssertEqual(nodeInfo.usage.users.total, 123)
        XCTAssertEqual(nodeInfo.usage.users.activeHalfyear, 42)
        XCTAssertEqual(nodeInfo.usage.users.activeMonth, 23)
        XCTAssertEqual(nodeInfo.usage.localPosts, 500)
        XCTAssertEqual(nodeInfo.usage.localComments, 1000)
        XCTAssertTrue(nodeInfo.metadata.chatEnabled)
    }

    func testAnyNodeInfo() throws {
    nodeInfo1:
        do {
            let nodeInfo = try Self.jsonDecoder.decode(NodeInfo1<ExampleMetadata1_0>.self, from: Self.example1_0)
            let anyNodeInfo = AnyNodeInfo(erasing: nodeInfo)
            XCTAssertEqual(anyNodeInfo.version, .v1)
            if case .struct(let software) = anyNodeInfo.software {
                XCTAssertEqual(software.name, "diaspora")
                XCTAssertEqual(software.version, "0.5.0")
            }
            else {
                XCTFail("Failed to match 'anyNodeInfo.software'.")
            }
            if case .struct(let protocols) = anyNodeInfo.protocols {
                XCTAssertEqual(protocols.inbound, ["diaspora"])
                XCTAssertEqual(protocols.outbound, ["diaspora"])
            }
            else {
                XCTFail("Failed to match 'anyNodeInfo.protocols'.")
            }
            if case .struct(let services) = anyNodeInfo.services {
                XCTAssertEqual(services.inbound, ["gnusocial"])
                XCTAssertEqual(services.outbound, ["facebook", "twitter"])
            }
            else {
                XCTFail("Failed to match 'anyNodeInfo.services'.")
            }
            XCTAssertTrue(nodeInfo.openRegistrations)
            if case .struct(let usage) = anyNodeInfo.usage {
                if case .struct(let users) = usage.users {
                    XCTAssertEqual(users.total, 123)
                    XCTAssertEqual(users.activeHalfyear, 42)
                    XCTAssertEqual(users.activeMonth, 23)
                }
                else {
                    XCTFail("Failed to match 'usage.users'.")
                }
                XCTAssertEqual(usage.localPosts, 500)
                XCTAssertEqual(usage.localComments, 1000)
            }
            else {
                XCTFail("Failed to match 'anyNodeInfo.usage'.")
            }
            XCTAssertEqual(anyNodeInfo.metadata?.chatEnabled, .bool(true))
        }
    nodeInfo1_1:
        do {
            let nodeInfo = try Self.jsonDecoder.decode(NodeInfo1_1<ExampleMetadata1_1>.self, from: Self.example1_1)
            let anyNodeInfo = AnyNodeInfo(erasing: nodeInfo)
            XCTAssertEqual(anyNodeInfo.version, .v1_1)
            if case .struct(let software) = anyNodeInfo.software {
                XCTAssertEqual(software.name, "diaspora")
                XCTAssertEqual(software.version, "0.5.0")
            }
            else {
                XCTFail("Failed to match 'anyNodeInfo.software'.")
            }
            if case .struct(let protocols) = anyNodeInfo.protocols {
                XCTAssertEqual(protocols.inbound, ["diaspora"])
                XCTAssertEqual(protocols.outbound, ["diaspora"])
            }
            else {
                XCTFail("Failed to match 'anyNodeInfo.protocols'.")
            }
            if case .struct(let services) = anyNodeInfo.services {
                XCTAssertEqual(services.inbound, ["gnusocial"])
                XCTAssertEqual(services.outbound, ["facebook", "twitter"])
            }
            else {
                XCTFail("Failed to match 'anyNodeInfo.services'.")
            }
            XCTAssertTrue(nodeInfo.openRegistrations)
            if case .struct(let usage) = anyNodeInfo.usage {
                if case .struct(let users) = usage.users {
                    XCTAssertEqual(users.total, 123)
                    XCTAssertEqual(users.activeHalfyear, 42)
                    XCTAssertEqual(users.activeMonth, 23)
                }
                else {
                    XCTFail("Failed to match 'usage.users'.")
                }
                XCTAssertEqual(usage.localPosts, 500)
                XCTAssertEqual(usage.localComments, 1000)
            }
            else {
                XCTFail("Failed to match 'anyNodeInfo.usage'.")
            }
            XCTAssertEqual(anyNodeInfo.metadata?.chatEnabled, .bool(true))
        }
    nodeInfo2:
        do {
            let nodeInfo = try Self.jsonDecoder.decode(NodeInfo2<ExampleMetadata2_0>.self, from: Self.example2_0)
            let anyNodeInfo = AnyNodeInfo(erasing: nodeInfo)
            XCTAssertEqual(anyNodeInfo.version, .v2)
            if case .struct(let software) = anyNodeInfo.software {
                XCTAssertEqual(software.name, "diaspora")
                XCTAssertEqual(software.version, "0.5.0")
            }
            else {
                XCTFail("Failed to match 'anyNodeInfo.software'.")
            }
            if case .set(let protocols) = anyNodeInfo.protocols {
                XCTAssertEqual(protocols, ["diaspora"])
            }
            else {
                XCTFail("Failed to match 'anyNodeInfo.protocols'.")
            }
            if case .struct(let services) = anyNodeInfo.services {
                XCTAssertEqual(services.inbound, ["gnusocial"])
                XCTAssertEqual(services.outbound, ["facebook", "twitter"])
            }
            else {
                XCTFail("Failed to match 'anyNodeInfo.services'.")
            }
            XCTAssertTrue(nodeInfo.openRegistrations)
            if case .struct(let usage) = anyNodeInfo.usage {
                if case .struct(let users) = usage.users {
                    XCTAssertEqual(users.total, 123)
                    XCTAssertEqual(users.activeHalfyear, 42)
                    XCTAssertEqual(users.activeMonth, 23)
                }
                else {
                    XCTFail("Failed to match 'usage.users'.")
                }
                XCTAssertEqual(usage.localPosts, 500)
                XCTAssertEqual(usage.localComments, 1000)
            }
            else {
                XCTFail("Failed to match 'anyNodeInfo.usage'.")
            }
            XCTAssertEqual(anyNodeInfo.metadata?.chatEnabled, .bool(true))
        }
    nodeInfo2_1:
        do {
            let nodeInfo = try Self.jsonDecoder.decode(NodeInfo2_1<ExampleMetadata2_1>.self, from: Self.example2_1)
            let anyNodeInfo = AnyNodeInfo(erasing: nodeInfo)
            XCTAssertEqual(anyNodeInfo.version, .v2_1)
            if case .struct(let software) = anyNodeInfo.software {
                XCTAssertEqual(software.name, "diaspora")
                XCTAssertEqual(software.version, "0.5.0")
                XCTAssertEqual(software.repository, "https://github.com/diaspora/diaspora")
                XCTAssertEqual(software.homepage, "https://diasporafoundation.org/")
            }
            else {
                XCTFail("Failed to match 'anyNodeInfo.software'.")
            }
            if case .set(let protocols) = anyNodeInfo.protocols {
                XCTAssertEqual(protocols, ["diaspora"])
            }
            else {
                XCTFail("Failed to match 'anyNodeInfo.protocols'.")
            }
            if case .struct(let services) = anyNodeInfo.services {
                XCTAssertEqual(services.inbound, ["gnusocial"])
                XCTAssertEqual(services.outbound, ["facebook", "twitter"])
            }
            else {
                XCTFail("Failed to match 'anyNodeInfo.services'.")
            }
            XCTAssertTrue(nodeInfo.openRegistrations)
            if case .struct(let usage) = anyNodeInfo.usage {
                if case .struct(let users) = usage.users {
                    XCTAssertEqual(users.total, 123)
                    XCTAssertEqual(users.activeHalfyear, 42)
                    XCTAssertEqual(users.activeMonth, 23)
                }
                else {
                    XCTFail("Failed to match 'usage.users'.")
                }
                XCTAssertEqual(usage.localPosts, 500)
                XCTAssertEqual(usage.localComments, 1000)
            }
            else {
                XCTFail("Failed to match 'anyNodeInfo.usage'.")
            }
            XCTAssertEqual(anyNodeInfo.metadata?.chatEnabled, .bool(true))
        }
    }
}
