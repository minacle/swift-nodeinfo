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
        let nodeinfo = try Self.jsonDecoder.decode(NodeInfo1<ExampleMetadata1_0>.self, from: Self.example1_0)
        XCTAssertEqual(nodeinfo.version, .v1)
        XCTAssertEqual(nodeinfo.software.name, .diaspora)
        XCTAssertEqual(nodeinfo.software.version, "0.5.0")
        XCTAssertEqual(nodeinfo.protocols.inbound, [.diaspora])
        XCTAssertEqual(nodeinfo.protocols.outbound, [.diaspora])
        XCTAssertEqual(nodeinfo.services.inbound, [.gnusocial])
        XCTAssertEqual(nodeinfo.services.outbound, [.facebook, .twitter])
        XCTAssertTrue(nodeinfo.openRegistrations)
        XCTAssertEqual(nodeinfo.usage.users.total, 123)
        XCTAssertEqual(nodeinfo.usage.users.activeHalfyear, 42)
        XCTAssertEqual(nodeinfo.usage.users.activeMonth, 23)
        XCTAssertEqual(nodeinfo.usage.localPosts, 500)
        XCTAssertEqual(nodeinfo.usage.localComments, 1000)
        XCTAssertTrue(nodeinfo.metadata.chatEnabled)
    }

    func testNodeInfo1_1() throws {
        let nodeinfo = try Self.jsonDecoder.decode(NodeInfo1_1<ExampleMetadata1_1>.self, from: Self.example1_1)
        XCTAssertEqual(nodeinfo.version, .v1_1)
        XCTAssertEqual(nodeinfo.software.name, .diaspora)
        XCTAssertEqual(nodeinfo.software.version, "0.5.0")
        XCTAssertEqual(nodeinfo.protocols.inbound, [.diaspora])
        XCTAssertEqual(nodeinfo.protocols.outbound, [.diaspora])
        XCTAssertEqual(nodeinfo.services.inbound, [.gnusocial])
        XCTAssertEqual(nodeinfo.services.outbound, [.facebook, .twitter])
        XCTAssertTrue(nodeinfo.openRegistrations)
        XCTAssertEqual(nodeinfo.usage.users.total, 123)
        XCTAssertEqual(nodeinfo.usage.users.activeHalfyear, 42)
        XCTAssertEqual(nodeinfo.usage.users.activeMonth, 23)
        XCTAssertEqual(nodeinfo.usage.localPosts, 500)
        XCTAssertEqual(nodeinfo.usage.localComments, 1000)
        XCTAssertTrue(nodeinfo.metadata.chatEnabled)
    }

    func testNodeInfo2() throws {
        let nodeinfo = try Self.jsonDecoder.decode(NodeInfo2<ExampleMetadata2_0>.self, from: Self.example2_0)
        XCTAssertEqual(nodeinfo.version, .v2)
        XCTAssertEqual(nodeinfo.software.name, "diaspora")
        XCTAssertEqual(nodeinfo.software.version, "0.5.0")
        XCTAssertEqual(nodeinfo.protocols, [.diaspora])
        XCTAssertEqual(nodeinfo.services.inbound, [.gnusocial])
        XCTAssertEqual(nodeinfo.services.outbound, [.facebook, .twitter])
        XCTAssertTrue(nodeinfo.openRegistrations)
        XCTAssertEqual(nodeinfo.usage.users.total, 123)
        XCTAssertEqual(nodeinfo.usage.users.activeHalfyear, 42)
        XCTAssertEqual(nodeinfo.usage.users.activeMonth, 23)
        XCTAssertEqual(nodeinfo.usage.localPosts, 500)
        XCTAssertEqual(nodeinfo.usage.localComments, 1000)
        XCTAssertTrue(nodeinfo.metadata.chatEnabled)
    }

    func testNodeInfo2_1() throws {
        let nodeinfo = try Self.jsonDecoder.decode(NodeInfo2_1<ExampleMetadata2_1>.self, from: Self.example2_1)
        XCTAssertEqual(nodeinfo.version, .v2_1)
        XCTAssertEqual(nodeinfo.software.name, "diaspora")
        XCTAssertEqual(nodeinfo.software.version, "0.5.0")
        XCTAssertEqual(nodeinfo.software.repository, "https://github.com/diaspora/diaspora")
        XCTAssertEqual(nodeinfo.software.homepage, "https://diasporafoundation.org/")
        XCTAssertEqual(nodeinfo.protocols, [.diaspora])
        XCTAssertEqual(nodeinfo.services.inbound, [.gnusocial])
        XCTAssertEqual(nodeinfo.services.outbound, [.facebook, .twitter])
        XCTAssertTrue(nodeinfo.openRegistrations)
        XCTAssertEqual(nodeinfo.usage.users.total, 123)
        XCTAssertEqual(nodeinfo.usage.users.activeHalfyear, 42)
        XCTAssertEqual(nodeinfo.usage.users.activeMonth, 23)
        XCTAssertEqual(nodeinfo.usage.localPosts, 500)
        XCTAssertEqual(nodeinfo.usage.localComments, 1000)
        XCTAssertTrue(nodeinfo.metadata.chatEnabled)
    }
}
