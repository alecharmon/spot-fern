import Foundation

public struct GetLikesFriendsAggregateResponseItem: Codable, Hashable, Sendable {
    public let poi: GetLikesFriendsAggregateResponseItemPoi
    public let count: Int
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        poi: GetLikesFriendsAggregateResponseItemPoi,
        count: Int,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.poi = poi
        self.count = count
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.poi = try container.decode(GetLikesFriendsAggregateResponseItemPoi.self, forKey: .poi)
        self.count = try container.decode(Int.self, forKey: .count)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.poi, forKey: .poi)
        try container.encode(self.count, forKey: .count)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case poi
        case count
    }
}