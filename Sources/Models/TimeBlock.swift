import Foundation
import SwiftData

@Model
final class TimeBlock: Taggable {
    @Attribute(.unique) var id: UUID
    
    // For syncing with Google Calendar
    @Attribute(.unique) var googleEventID: String?
    
    var title: String
    var startDate: Date
    var endDate: Date
    var duration: TimeInterval // Cached duration in seconds
    var isAllDay: Bool
    
    // Relationships
    
    // Optional link to a Task (e.g. "Work on Thesis")
    @Relationship(inverse: \Task.timeBlocks)
    var linkedTask: Task?
    
    // Optional link to a Note (e.g. "Read Paper X")
    @Relationship(inverse: \Note.timeBlocks)
    var linkedNote: Note?
    
    // Tags for categorization (e.g. "Deep Work", "Admin")
    @Relationship(inverse: \Tag.timeBlocks)
    var tags: [Tag]?
    
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
        // Ensure endDate is not before startDate
        self.endDate = max(startDate, endDate)
        self.duration = self.endDate.timeIntervalSince(self.startDate)
        self.isAllDay = isAllDay
    }

    /// Updates the duration based on start and end dates.
    /// Ensures endDate is not before startDate.
    func updateDuration(newStartDate: Date? = nil, newEndDate: Date? = nil) {
        if let start = newStartDate {
            self.startDate = start
        }

        if let end = newEndDate {
            self.endDate = end
        }

        // Ensure endDate >= startDate
        if self.endDate < self.startDate {
            self.endDate = self.startDate
        }

        self.duration = self.endDate.timeIntervalSince(self.startDate)
    }
}
