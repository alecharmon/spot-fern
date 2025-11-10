import Foundation

extension Requests {
    public struct PostPoisRequest: Codable, Hashable, Sendable {
        public let name: String
        public let description: String?
        public let lat: Double
        public let lng: Double
        public let createdById: String?
        public let appleMapId: String?
        public let metadata: [String: JSONValue]?
        public let tag: String?
        public let visibility: PostPoisRequestVisibility?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            name: String,
            description: String? = nil,
            lat: Double,
            lng: Double,
            createdById: String? = nil,
            appleMapId: String? = nil,
            metadata: [String: JSONValue]? = nil,
            tag: String? = nil,
            visibility: PostPoisRequestVisibility? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.name = name
            self.description = description
            self.lat = lat
            self.lng = lng
            self.createdById = createdById
            self.appleMapId = appleMapId
            self.metadata = metadata
            self.tag = tag
            self.visibility = visibility
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try container.decode(String.self, forKey: .name)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.lat = try container.decode(Double.self, forKey: .lat)
            self.lng = try container.decode(Double.self, forKey: .lng)
            self.createdById = try container.decodeIfPresent(String.self, forKey: .createdById)
            self.appleMapId = try container.decodeIfPresent(String.self, forKey: .appleMapId)
            self.metadata = try container.decodeIfPresent([String: JSONValue].self, forKey: .metadata)
            self.tag = try container.decodeIfPresent(String.self, forKey: .tag)
            self.visibility = try container.decodeIfPresent(PostPoisRequestVisibility.self, forKey: .visibility)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.name, forKey: .name)
            try container.encodeIfPresent(self.description, forKey: .description)
            try container.encode(self.lat, forKey: .lat)
            try container.encode(self.lng, forKey: .lng)
            try container.encodeIfPresent(self.createdById, forKey: .createdById)
            try container.encodeIfPresent(self.appleMapId, forKey: .appleMapId)
            try container.encodeIfPresent(self.metadata, forKey: .metadata)
            try container.encodeIfPresent(self.tag, forKey: .tag)
            try container.encodeIfPresent(self.visibility, forKey: .visibility)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case name
            case description
            case lat
            case lng
            case createdById
            case appleMapId
            case metadata
            case tag
            case visibility
        }
    }
}