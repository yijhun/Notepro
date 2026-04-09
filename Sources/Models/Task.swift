import Foundation
import SwiftData

@Model
final class Task: Taggable, TimeBlockable, Embeddable {
    enum Priority: Int, Codable, CaseIterable {
        case none = 0
        case low = 1
        case medium = 2
        case high = 3
    }

    @Attribute(.unique) var id: UUID
    var title: String
    var isCompleted: Bool
    var dueDate: Date?
    var priority: Priority
    var createdAt: Date
    
    // Embedding for Semantic Search / RAG (Optional)
    var embeddingData: Data?

    var embedding: [Float]? {
        get { embeddingData?.toFloatArray() }
        set { embeddingData = newValue?.toData() }
    }

    // Timer State Persistence
    var timerStartTime: Date? // If not nil, timer is running since this date
    var accumulatedTime: TimeInterval // Total time tracked before current session
    
    // Relationships
    
    // Linked Note (e.g. if task is created within a note)
    var linkedNote: Note?
    
    // Tags: Many-to-Many
    @Relationship(inverse: \Tag.tasks)
    var tags: [Tag]?
    
    // TimeBlocks associated with this task (e.g. focused work sessions)
    var timeBlocks: [TimeBlock]?
    
    init(
        id: UUID = UUID(),
        title: String,
        isCompleted: Bool = false,
        dueDate: Date? = nil,
        priority: Priority = .none,
        createdAt: Date = Date(),
        embedding: [Float]? = nil,
        timerStartTime: Date? = nil,
        accumulatedTime: TimeInterval = 0
    ) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.dueDate = dueDate
        self.priority = priority
        self.createdAt = createdAt
        self.embeddingData = embedding?.toData()
        self.timerStartTime = timerStartTime
        self.accumulatedTime = accumulatedTime
    }
}
