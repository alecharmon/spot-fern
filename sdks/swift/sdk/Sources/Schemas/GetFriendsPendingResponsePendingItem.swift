import Foundation

public struct GetFriendsPendingResponsePendingItem: Codable, Hashable, Sendable {
    public let friend: GetFriendsPendingResponsePendingItemFriend
    public let requestedAt: Date
    public let direction: GetFriendsPendingResponsePendingItemDirection
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        friend: GetFriendsPendingResponsePendingItemFriend,
        requestedAt: Date,
        direction: GetFriendsPendingResponsePendingItemDirection,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.friend = friend
        self.requestedAt = requestedAt
        self.direction = direction
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.friend = try container.decode(GetFriendsPendingResponsePendingItemFriend.self, forKey: .friend)
        self.requestedAt = try container.decode(Date.self, forKey: .requestedAt)
        self.direction = try container.decode(GetFriendsPendingResponsePendingItemDirection.self, forKey: .direction)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.friend, forKey: .friend)
        try container.encode(self.requestedAt, forKey: .requestedAt)
        try container.encode(self.direction, forKey: .direction)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case friend
        case requestedAt
        case direction
    }
}