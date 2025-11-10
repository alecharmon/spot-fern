import Foundation

public enum PostPoisResponseStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case liked = "Liked"
    case notLiked = "Not Liked"
}