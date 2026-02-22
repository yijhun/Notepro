import Foundation
import SwiftData

@Model
public final class Task: Taggable, TimeBlockable, Embeddable {
    @Attribute(.unique) public var id: UUID
    public var title: String
    public var isCompleted: Bool
    public var dueDate: Date?
    public var priority: Int // 0: None, 1: Low, 2: Medium, 3: High
    public var createdAt: Date
    
    // Embedding for Semantic Search / RAG (Optional)
    public var embedding: [Float]?
    
    // Relationships
    
    // Linked Note (e.g. if task is created within a note)
    @Relationship(inverse: \Note.tasks)
    public var linkedNote: Note?
    
    // Tags: Many-to-Many
    @Relationship(inverse: \Tag.tasks)
    public var tags: [Tag]?
    
    // TimeBlocks associated with this task (e.g. focused work sessions)
    @Relationship(inverse: \TimeBlock.linkedTask)
    public var timeBlocks: [TimeBlock]?
    
    public init(
        id: UUID = UUID(),
        title: String,
        isCompleted: Bool = false,
        dueDate: Date? = nil,
        priority: Int = 0,
        createdAt: Date = Date(),
        embedding: [Float]? = nil
    ) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.dueDate = dueDate
        self.priority = priority
        self.createdAt = createdAt
        self.embedding = embedding
    }
}

extension Task {
    public enum Priority: Int, Codable, CaseIterable {
        case none = 0
        case low = 1
        case medium = 2
        case high = 3
    }
}
