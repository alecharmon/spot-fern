import Foundation

public enum GetPoisResponseItemStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case liked = "Liked"
    case notLiked = "Not Liked"
}