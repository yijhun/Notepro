import Foundation
import SwiftData

@Model // Core schema for Task
final class Task: Taggable, TimeBlockable, Embeddable {
    enum Priority: Int, Codable {
        case none = 0
        case low = 1
        case medium = 2
        case high = 3
    }

    var id: UUID = UUID()
    var title: String = ""
    var isCompleted: Bool = false
    var dueDate: Date? = nil
    var priority: Int = Priority.none.rawValue
    var createdAt: Date = Date()
    
    // Embedding for Semantic Search / RAG (Optional)
    var embeddingData: Data? = nil

    var embedding: [Float]? {
        get { embeddingData?.toFloatArray() }
        set { embeddingData = newValue?.toData() }
    }

    // Timer State Persistence
    var timerStartTime: Date? = nil // If not nil, timer is running since this date
    var accumulatedTime: TimeInterval = 0 // Total time tracked before current session
    
    // Relationships
    
    // Linked Note (e.g. if task is created within a note)
    @Relationship(inverse: \Note.tasks)
    var linkedNote: Note?
    
    // Tags: Many-to-Many
    @Relationship(inverse: \Tag.tasks)
    var tags: [Tag]? = []
    
    // TimeBlocks associated with this task (e.g. focused work sessions)
    var timeBlocks: [TimeBlock]? = []
    
    init(
        id: UUID = UUID(),
        title: String,
        isCompleted: Bool = false,
        dueDate: Date? = nil,
        priority: Int = 0,
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
        self.embedding = embedding
        self.timerStartTime = timerStartTime
        self.accumulatedTime = accumulatedTime
    }
}
