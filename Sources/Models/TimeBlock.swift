import Foundation
import SwiftData

@Model // Core schema for TimeBlock
final class TimeBlock: Taggable {
    var id: UUID = UUID()
    
    // For syncing with Google Calendar
    var googleEventID: String? = nil
    
    var title: String = ""
    var startDate: Date = Date()
    var endDate: Date = Date()

    var duration: TimeInterval { max(0, endDate.timeIntervalSince(startDate)) }
    var isAllDay: Bool = false
    
    // Relationships
    
    // Optional link to a Task (e.g. "Work on Thesis")
    @Relationship(inverse: \Task.timeBlocks)
    var linkedTask: Task? = nil
    
    // Optional link to a Note (e.g. "Read Paper X")
    @Relationship(inverse: \Note.timeBlocks)
    var linkedNote: Note? = nil
    
    // Tags for categorization (e.g. "Deep Work", "Admin")
    var tags: [Tag]? = nil
    
    init(
        id: UUID = UUID(),
        googleEventID: String? = nil,
        title: String,
        startDate: Date,
        endDate: Date,
        isAllDay: Bool = false
    ) {
        self.id = id
        self.googleEventID = googleEventID
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.isAllDay = isAllDay
    }
}
