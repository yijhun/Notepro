import Foundation

/// Protocol for items that can be tagged
protocol Taggable: AnyObject {
    var tags: [Tag]? { get set }
}

/// Protocol for items that can have associated time blocks (events)
protocol TimeBlockable: AnyObject {
    var timeBlocks: [TimeBlock]? { get set }
}

/// Protocol for items that support vector embeddings for semantic search
protocol Embeddable: AnyObject {
    var embedding: Data? { get set }
}
