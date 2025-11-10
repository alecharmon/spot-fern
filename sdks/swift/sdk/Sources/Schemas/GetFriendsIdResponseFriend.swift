import Foundation

public struct GetFriendsIdResponseFriend: Codable, Hashable, Sendable {
    public let id: String
    public let handle: String
    public let clerkId: String?
    public let createdAt: Date
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        id: String,
        handle: String,
        clerkId: String? = nil,
        createdAt: Date,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.id = id
        self.handle = handle
        self.clerkId = clerkId
        self.createdAt = createdAt
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.handle = try container.decode(String.self, forKey: .handle)
        self.clerkId = try container.decodeIfPresent(String.self, forKey: .clerkId)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.handle, forKey: .handle)
        try container.encodeIfPresent(self.clerkId, forKey: .clerkId)
        try container.encode(self.createdAt, forKey: .createdAt)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case handle
        case clerkId
        case createdAt
    }
}