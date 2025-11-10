import Foundation

public struct GetFriendsResponseDataItem: Codable, Hashable, Sendable {
    public let friend: GetFriendsResponseDataItemFriend
    public let since: Date
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        friend: GetFriendsResponseDataItemFriend,
        since: Date,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.friend = friend
        self.since = since
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.friend = try container.decode(GetFriendsResponseDataItemFriend.self, forKey: .friend)
        self.since = try container.decode(Date.self, forKey: .since)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.friend, forKey: .friend)
        try container.encode(self.since, forKey: .since)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case friend
        case since
    }
}