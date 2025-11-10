import Foundation

public struct GetPoisIdResponseFriendsItem: Codable, Hashable, Sendable {
    public let id: String
    public let handle: String
    public let like: GetPoisIdResponseFriendsItemLike
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        id: String,
        handle: String,
        like: GetPoisIdResponseFriendsItemLike,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.id = id
        self.handle = handle
        self.like = like
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.handle = try container.decode(String.self, forKey: .handle)
        self.like = try container.decode(GetPoisIdResponseFriendsItemLike.self, forKey: .like)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.handle, forKey: .handle)
        try container.encode(self.like, forKey: .like)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case handle
        case like
    }
}