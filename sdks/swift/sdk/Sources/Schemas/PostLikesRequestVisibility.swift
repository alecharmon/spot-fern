import Foundation

public enum PostLikesRequestVisibility: String, Codable, Hashable, CaseIterable, Sendable {
    case `public` = "PUBLIC"
    case `private` = "PRIVATE"
    case friendsOnly = "FRIENDS_ONLY"
}