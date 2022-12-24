import Foundation

extension NodeInfoTests {

    struct ExampleMetadata1_0: Codable, Sendable {

        var chatEnabled: Bool
    }

    struct ExampleMetadata1_1: Codable, Sendable {

        var chatEnabled: Bool
    }

    struct ExampleMetadata2_0: Codable, Sendable {

        var chatEnabled: Bool
    }

    struct ExampleMetadata2_1: Codable, Sendable {

        var chatEnabled: Bool
    }

    static let example1_0: Data =
        """
        {
          "version": "1.0",
          "software": {
            "name": "diaspora",
            "version": "0.5.0"
          },
          "protocols": {
            "inbound": ["diaspora"],
            "outbound": ["diaspora"]
          },
          "services": {
            "inbound": ["gnusocial"],
            "outbound": ["facebook", "twitter"]
          },
          "openRegistrations": true,
          "usage": {
            "users": {
              "total": 123,
              "activeHalfyear": 42,
              "activeMonth": 23
            },
            "localPosts": 500,
            "localComments": 1000
          },
          "metadata": {
            "chat_enabled": true
          }
        }
        """
        .data(using: .utf8)!

    static let example1_1: Data =
        """
        {
          "version": "1.1",
          "software": {
            "name": "diaspora",
            "version": "0.5.0"
          },
          "protocols": {
            "inbound": ["diaspora"],
            "outbound": ["diaspora"]
          },
          "services": {
            "inbound": ["gnusocial"],
            "outbound": ["facebook", "twitter"]
          },
          "openRegistrations": true,
          "usage": {
            "users": {
              "total": 123,
              "activeHalfyear": 42,
              "activeMonth": 23
            },
            "localPosts": 500,
            "localComments": 1000
          },
          "metadata": {
            "chat_enabled": true
          }
        }
        """
        .data(using: .utf8)!

    static let example2_0: Data =
        """
        {
          "version": "2.0",
          "software": {
            "name": "diaspora",
            "version": "0.5.0"
          },
          "protocols": ["diaspora"],
          "services": {
            "inbound": ["gnusocial"],
            "outbound": ["facebook", "twitter"]
          },
          "openRegistrations": true,
          "usage": {
            "users": {
              "total": 123,
              "activeHalfyear": 42,
              "activeMonth": 23
            },
            "localPosts": 500,
            "localComments": 1000
          },
          "metadata": {
            "chat_enabled": true
          }
        }
        """
        .data(using: .utf8)!

    static let example2_1: Data =
        """
        {
          "version": "2.1",
          "software": {
            "name": "diaspora",
            "version": "0.5.0",
            "repository": "https://github.com/diaspora/diaspora",
            "homepage": "https://diasporafoundation.org/"
          },
          "protocols": ["diaspora"],
          "services": {
            "inbound": ["gnusocial"],
            "outbound": ["facebook", "twitter"]
          },
          "openRegistrations": true,
          "usage": {
            "users": {
              "total": 123,
              "activeHalfyear": 42,
              "activeMonth": 23
            },
            "localPosts": 500,
            "localComments": 1000
          },
          "metadata": {
            "chat_enabled": true
          }
        }
        """
        .data(using: .utf8)!
}
