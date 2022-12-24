public protocol NodeInfoSetProtocol<Element>: Codable, Collection, Hashable, Sendable, SetAlgebra
where Element: Codable & Hashable & Sendable {
}

// MARK: -

internal protocol _NodeInfoSetProtocol<Element>: NodeInfoSetProtocol
where Index == Set<Element>.Index {

    var _internalSet: Set<Element> {get set}

    init(_internalSet: Set<Element>)
}

extension _NodeInfoSetProtocol {

    internal init(_internalSet: Set<Element>) {
        self.init()
        self._internalSet = _internalSet
    }

    // MARK: Codable

    public init(from decoder: Decoder) throws {
        self.init()
        self._internalSet = try .init(from: decoder)
    }

    public func encode(to encoder: Encoder) throws {
        try self._internalSet.encode(to: encoder)
    }

    // MARK: Collection

    public var startIndex: Index {
        _internalSet.startIndex
    }

    public var endIndex: Index {
        _internalSet.endIndex
    }

    public subscript(position: Index) -> Element {
        _internalSet[position]
    }

    public func index(after i: Index) -> Index {
        _internalSet.index(after: i)
    }

    // MARK: SetAlgebra

    public func contains(_ member: Element) -> Bool {
        _internalSet.contains(member)
    }

    @discardableResult
    public mutating func insert(_ newMember: Element) -> (inserted: Bool, memberAfterInsert: Element) {
        _internalSet.insert(newMember)
    }

    @discardableResult
    public mutating func update(with newMember: Element) -> Element? {
        _internalSet.update(with: newMember)
    }

    @discardableResult
    public mutating func remove(_ member: Element) -> Element? {
        _internalSet.remove(member)
    }

    public func union(_ other: Self) -> Self {
        .init(_internalSet: _internalSet.union(other._internalSet))
    }

    public mutating func formUnion(_ other: Self) {
        _internalSet.formUnion(other._internalSet)
    }

    public func intersection(_ other: Self) -> Self {
        .init(_internalSet: _internalSet.intersection(other._internalSet))
    }

    public mutating func formIntersection(_ other: Self) {
        _internalSet.formIntersection(other._internalSet)
    }

    public func symmetricDifference(_ other: Self) -> Self {
        .init(_internalSet: _internalSet.symmetricDifference(other._internalSet))
    }

    public mutating func formSymmetricDifference(_ other: Self) {
        _internalSet.formSymmetricDifference(other._internalSet)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs._internalSet == rhs._internalSet
    }

    public var isEmpty: Bool {
        _internalSet.isEmpty
    }
}
