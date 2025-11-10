import Foundation

public struct PostLikesResponse: Codable, Hashable, Sendable {
    public let userId: String
    public let poiId: String
    public let tag: String
    public let visibility: PostLikesResponseVisibility
    public let createdAt: Date
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        userId: String,
        poiId: String,
        tag: String,
        visibility: PostLikesResponseVisibility,
        createdAt: Date,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.userId = userId
        self.poiId = poiId
        self.tag = tag
        self.visibility = visibility
        self.createdAt = createdAt
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.poiId = try container.decode(String.self, forKey: .poiId)
        self.tag = try container.decode(String.self, forKey: .tag)
        self.visibility = try container.decode(PostLikesResponseVisibility.self, forKey: .visibility)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.userId, forKey: .userId)
        try container.encode(self.poiId, forKey: .poiId)
        try container.encode(self.tag, forKey: .tag)
        try container.encode(self.visibility, forKey: .visibility)
        try container.encode(self.createdAt, forKey: .createdAt)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case userId
        case poiId
        case tag
        case visibility
        case createdAt
    }
}