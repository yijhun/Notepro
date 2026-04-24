import Foundation
import SwiftData

@Model // Core schema for TimeBlock
final class TimeBlock: Taggable {
    var id: UUID = UUID()
    
    // For syncing with Google Calendar
    var googleEventID: String? = nil
    
    var title: String = ""
    var startDate: Date = Date() {
        didSet {
            recalculateDuration()
        }
    }

    var endDate: Date = Date() {
        didSet {
            recalculateDuration()
        }
    }

    var duration: TimeInterval = 0 // Cached duration in seconds
    var isAllDay: Bool = false
    
    // Relationships
    
    // Optional link to a Task (e.g. "Work on Thesis")
    @Relationship(inverse: \Task.timeBlocks)
    var linkedTask: Task? = nil
    
    // Optional link to a Note (e.g. "Read Paper X")
    @Relationship(inverse: \Note.timeBlocks)
    var linkedNote: Note? = nil
    
    // Tags for categorization (e.g. "Deep Work", "Admin")
    @Relationship(inverse: \Tag.timeBlocks)
    var tags: [Tag]? = nil
    
    init(
        id: UUID = UUID(),
        googleEventID: String? = nil,
        title: String = "",
        startDate: Date = Date(),
        endDate: Date = Date(),
        isAllDay: Bool = false
    ) {
        self.id = id
        self.googleEventID = googleEventID
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.isAllDay = isAllDay
        recalculateDuration()
    }

    /// Recalculates the duration based on start and end dates.
    /// Call this manually if automated updates fail or when bulk editing.
    func recalculateDuration() {
        self.duration = endDate.timeIntervalSince(startDate)
    }
}
