import Foundation

public struct GetLikesFriendsAggregateNearbyResponseItemPoi: Codable, Hashable, Sendable {
    public let id: String
    public let name: String
    public let description: String?
    public let lat: Double
    public let lng: Double
    public let createdById: String?
    public let appleMapId: String?
    public let metadata: JSONValue?
    public let createdAt: Date
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        id: String,
        name: String,
        description: String? = nil,
        lat: Double,
        lng: Double,
        createdById: String? = nil,
        appleMapId: String? = nil,
        metadata: JSONValue? = nil,
        createdAt: Date,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.lat = lat
        self.lng = lng
        self.createdById = createdById
        self.appleMapId = appleMapId
        self.metadata = metadata
        self.createdAt = createdAt
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.lat = try container.decode(Double.self, forKey: .lat)
        self.lng = try container.decode(Double.self, forKey: .lng)
        self.createdById = try container.decodeIfPresent(String.self, forKey: .createdById)
        self.appleMapId = try container.decodeIfPresent(String.self, forKey: .appleMapId)
        self.metadata = try container.decodeIfPresent(JSONValue.self, forKey: .metadata)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encode(self.lat, forKey: .lat)
        try container.encode(self.lng, forKey: .lng)
        try container.encodeIfPresent(self.createdById, forKey: .createdById)
        try container.encodeIfPresent(self.appleMapId, forKey: .appleMapId)
        try container.encodeIfPresent(self.metadata, forKey: .metadata)
        try container.encode(self.createdAt, forKey: .createdAt)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case name
        case description
        case lat
        case lng
        case createdById
        case appleMapId
        case metadata
        case createdAt
    }
}