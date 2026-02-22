import Foundation

// MARK: - Shared Traits

/// Protocol for items that can be tagged
public protocol Taggable {
    var tags: [Tag]? { get set }
}

/// Protocol for items that can have associated time blocks (events)
public protocol TimeBlockable {
    var timeBlocks: [TimeBlock]? { get set }
}

/// Protocol for items that support vector embeddings for semantic search
public protocol Embeddable {
    var embedding: [Float]? { get set }
}
