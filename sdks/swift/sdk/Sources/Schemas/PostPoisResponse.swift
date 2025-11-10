import Foundation

public struct PostPoisResponse: Codable, Hashable, Sendable {
    public let poi: PostPoisResponsePoi
    public let status: PostPoisResponseStatus
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        poi: PostPoisResponsePoi,
        status: PostPoisResponseStatus,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.poi = poi
        self.status = status
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.poi = try container.decode(PostPoisResponsePoi.self, forKey: .poi)
        self.status = try container.decode(PostPoisResponseStatus.self, forKey: .status)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.poi, forKey: .poi)
        try container.encode(self.status, forKey: .status)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case poi
        case status
    }
}