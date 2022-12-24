import Foundation

public struct NodeInfoVersion: Codable, Comparable, RawRepresentable, Sendable {

    public var major: Int

    public var minor: Int

    public init(
        major: Int,
        minor: Int
    ) {
        self.major = major
        self.minor = minor
    }

    // MARK: RawRepresentable

    public var rawValue: String {
        "\(major).\(minor)"
    }

    public init?(rawValue: String) {
        if
            #available(macCatalyst 16, macOS 13, iOS 16, tvOS 16, watchOS 9, *),
            let nodeInfoVersion = Self.init(engine: .swift, rawValue: rawValue)
        {
            self = nodeInfoVersion
        }
        else {
            self.init(engine: .foundation, rawValue: rawValue)
        }
    }

    // MARK: Comparable

    public static func < (lhs: Self, rhs: Self) -> Bool {
        if lhs.major == rhs.major {
            return lhs.minor < rhs.minor
        }
        return lhs.major < rhs.major
    }

    public static func > (lhs: Self, rhs: Self) -> Bool {
        if lhs.major == rhs.major {
            return lhs.minor > rhs.minor
        }
        return lhs.major > rhs.major
    }
}

extension NodeInfoVersion {

    public static let v1: Self = .init(major: 1, minor: 0)

    public static let v1_1: Self = .init(major: 1, minor: 1)

    public static let v2: Self = .init(major: 2, minor: 0)

    public static let v2_1: Self = .init(major: 2, minor: 1)
}

extension NodeInfoVersion {

    private struct VersionContainer: Decodable {

        fileprivate var version: NodeInfoVersion
    }

    private static let jsonDecoder: JSONDecoder = .init()

    public init?(from encodedNodeInfo: Data) {
        guard
            let versionContainer =
                try? Self.jsonDecoder.decode(
                    VersionContainer.self,
                    from: encodedNodeInfo)
        else {
            return nil
        }
        self = versionContainer.version
    }
}

@available(macCatalyst, deprecated: 16)
@available(macOS, deprecated: 13)
@available(iOS, deprecated: 16)
@available(tvOS, deprecated: 16)
@available(watchOS, deprecated: 9)
extension NodeInfoVersion {

    private enum _Foundation {

        case foundation
    }

    private static let _nsRegex =
    try! NSRegularExpression(pattern: "^(\\d+)\\.(\\d+)$")

    private init?(engine _: _Foundation, rawValue: String) {
        let nsRawValue = rawValue as NSString
        if
            let match =
                Self._nsRegex.firstMatch(
                    in: rawValue,
                    range: .init(location: 0, length: nsRawValue.length))
        {
            var range: NSRange
            range = match.range(at: 1)
            if range.location != NSNotFound {
                major = .init(nsRawValue.substring(with: range))!
            }
            else {
                return nil
            }
            range = match.range(at: 2)
            if range.location != NSNotFound {
                minor = .init(nsRawValue.substring(with: range))!
            }
            else {
                return nil
            }
        }
        else {
            return nil
        }
    }
}

@available(macCatalyst, introduced: 16)
@available(macOS, introduced: 13)
@available(iOS, introduced: 16)
@available(tvOS, introduced: 16)
@available(watchOS, introduced: 9)
extension NodeInfoVersion {

    private enum _Swift {

        case swift
    }

#if canImport(_StringProcessing)
    private static let _regex =
        #/^(?<major>\d+)\.(?<minor>\d+)/#
#endif

    private init?(engine _: _Swift, rawValue: String) {
#if canImport(_StringProcessing)
        guard let match = try? Self._regex.firstMatch(in: rawValue)
        else {
            return nil
        }
        major = .init(match.output.major)!
        minor = .init(match.output.minor)!
#else
        return nil
#endif
    }
}
