import Foundation

public struct GetPoisIdResponse: Codable, Hashable, Sendable {
    public let poi: GetPoisIdResponsePoi
    public let friends: [GetPoisIdResponseFriendsItem]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        poi: GetPoisIdResponsePoi,
        friends: [GetPoisIdResponseFriendsItem],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.poi = poi
        self.friends = friends
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.poi = try container.decode(GetPoisIdResponsePoi.self, forKey: .poi)
        self.friends = try container.decode([GetPoisIdResponseFriendsItem].self, forKey: .friends)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.poi, forKey: .poi)
        try container.encode(self.friends, forKey: .friends)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case poi
        case friends
    }
}