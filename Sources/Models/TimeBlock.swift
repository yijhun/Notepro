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

        // Clamp endDate to be at least startDate
        let safeEndDate = (endDate < startDate) ? startDate : endDate
        self.endDate = safeEndDate
        self.duration = safeEndDate.timeIntervalSince(startDate)

        self.isAllDay = isAllDay
    }

    /// Updates the duration based on start and end dates.
    /// Also ensures endDate is not before startDate.
    func updateDuration() {
        if endDate < startDate {
            endDate = startDate
        }
        self.duration = endDate.timeIntervalSince(startDate)
    }
}
