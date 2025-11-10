import Foundation

public struct GetFriendsResponse: Codable, Hashable, Sendable {
    public let data: [GetFriendsResponseDataItem]
    public let pagination: GetFriendsResponsePagination
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        data: [GetFriendsResponseDataItem],
        pagination: GetFriendsResponsePagination,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.data = data
        self.pagination = pagination
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode([GetFriendsResponseDataItem].self, forKey: .data)
        self.pagination = try container.decode(GetFriendsResponsePagination.self, forKey: .pagination)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.data, forKey: .data)
        try container.encode(self.pagination, forKey: .pagination)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case data
        case pagination
    }
}