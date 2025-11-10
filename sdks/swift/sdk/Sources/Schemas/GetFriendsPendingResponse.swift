import Foundation

public struct GetFriendsPendingResponse: Codable, Hashable, Sendable {
    public let pending: [GetFriendsPendingResponsePendingItem]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        pending: [GetFriendsPendingResponsePendingItem],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.pending = pending
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pending = try container.decode([GetFriendsPendingResponsePendingItem].self, forKey: .pending)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.pending, forKey: .pending)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case pending
    }
}