import Foundation

public struct GetLikesFriendsAggregateNearbyResponseItem: Codable, Hashable, Sendable {
    public let poi: GetLikesFriendsAggregateNearbyResponseItemPoi
    public let count: Int
    public let distanceMeters: Double
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        poi: GetLikesFriendsAggregateNearbyResponseItemPoi,
        count: Int,
        distanceMeters: Double,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.poi = poi
        self.count = count
        self.distanceMeters = distanceMeters
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.poi = try container.decode(GetLikesFriendsAggregateNearbyResponseItemPoi.self, forKey: .poi)
        self.count = try container.decode(Int.self, forKey: .count)
        self.distanceMeters = try container.decode(Double.self, forKey: .distanceMeters)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.poi, forKey: .poi)
        try container.encode(self.count, forKey: .count)
        try container.encode(self.distanceMeters, forKey: .distanceMeters)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case poi
        case count
        case distanceMeters
    }
}