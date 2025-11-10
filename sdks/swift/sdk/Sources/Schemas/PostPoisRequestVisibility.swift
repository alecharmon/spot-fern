import Foundation

public enum PostPoisRequestVisibility: String, Codable, Hashable, CaseIterable, Sendable {
    case `public` = "PUBLIC"
    case `private` = "PRIVATE"
    case friendsOnly = "FRIENDS_ONLY"
}