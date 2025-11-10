import Foundation

public struct GetLikesMineResponseItem: Codable, Hashable, Sendable {
    public let poi: GetLikesMineResponseItemPoi
    public let tag: String
    public let visibility: GetLikesMineResponseItemVisibility
    public let createdAt: Date
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        poi: GetLikesMineResponseItemPoi,
        tag: String,
        visibility: GetLikesMineResponseItemVisibility,
        createdAt: Date,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.poi = poi
        self.tag = tag
        self.visibility = visibility
        self.createdAt = createdAt
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.poi = try container.decode(GetLikesMineResponseItemPoi.self, forKey: .poi)
        self.tag = try container.decode(String.self, forKey: .tag)
        self.visibility = try container.decode(GetLikesMineResponseItemVisibility.self, forKey: .visibility)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.poi, forKey: .poi)
        try container.encode(self.tag, forKey: .tag)
        try container.encode(self.visibility, forKey: .visibility)
        try container.encode(self.createdAt, forKey: .createdAt)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case poi
        case tag
        case visibility
        case createdAt
    }
}