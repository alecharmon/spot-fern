import Foundation

public struct GetPoisResponseItem: Codable, Hashable, Sendable {
    public let poi: GetPoisResponseItemPoi
    public let friendLikes: Int
    public let status: GetPoisResponseItemStatus
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        poi: GetPoisResponseItemPoi,
        friendLikes: Int,
        status: GetPoisResponseItemStatus,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.poi = poi
        self.friendLikes = friendLikes
        self.status = status
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.poi = try container.decode(GetPoisResponseItemPoi.self, forKey: .poi)
        self.friendLikes = try container.decode(Int.self, forKey: .friendLikes)
        self.status = try container.decode(GetPoisResponseItemStatus.self, forKey: .status)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.poi, forKey: .poi)
        try container.encode(self.friendLikes, forKey: .friendLikes)
        try container.encode(self.status, forKey: .status)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case poi
        case friendLikes = "friend_likes"
        case status
    }
}