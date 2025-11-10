import Foundation

public struct GetPoisIdResponseFriendsItemLike: Codable, Hashable, Sendable {
    public let tag: String
    public let visibility: GetPoisIdResponseFriendsItemLikeVisibility
    public let createdAt: Date
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        tag: String,
        visibility: GetPoisIdResponseFriendsItemLikeVisibility,
        createdAt: Date,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.tag = tag
        self.visibility = visibility
        self.createdAt = createdAt
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tag = try container.decode(String.self, forKey: .tag)
        self.visibility = try container.decode(GetPoisIdResponseFriendsItemLikeVisibility.self, forKey: .visibility)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.tag, forKey: .tag)
        try container.encode(self.visibility, forKey: .visibility)
        try container.encode(self.createdAt, forKey: .createdAt)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case tag
        case visibility
        case createdAt
    }
}