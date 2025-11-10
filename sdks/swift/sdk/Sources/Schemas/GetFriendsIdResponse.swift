import Foundation

public struct GetFriendsIdResponse: Codable, Hashable, Sendable {
    public let friend: GetFriendsIdResponseFriend
    public let likes: [GetFriendsIdResponseLikesItem]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        friend: GetFriendsIdResponseFriend,
        likes: [GetFriendsIdResponseLikesItem],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.friend = friend
        self.likes = likes
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.friend = try container.decode(GetFriendsIdResponseFriend.self, forKey: .friend)
        self.likes = try container.decode([GetFriendsIdResponseLikesItem].self, forKey: .likes)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.friend, forKey: .friend)
        try container.encode(self.likes, forKey: .likes)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case friend
        case likes
    }
}