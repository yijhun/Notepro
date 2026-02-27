import Foundation
import SwiftData

@Model
final class TimeBlock: Taggable {
    @Attribute(.unique) var id: UUID
    
    // For syncing with Google Calendar
    @Attribute(.unique) var googleEventID: String?
    
    var title: String

    // Private(set) to enforce consistency via setTimeRange
    private(set) var startDate: Date
    private(set) var endDate: Date

    private(set) var duration: TimeInterval // Cached duration in seconds
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
        if endDate < startDate {
            self.endDate = startDate
        } else {
            self.endDate = endDate
        }

        self.duration = self.endDate.timeIntervalSince(startDate)
        self.isAllDay = isAllDay
    }

    /// Updates the start and end dates, ensuring consistency and updating duration.
    /// Clamps endDate to startDate if it is earlier.
    func setTimeRange(start: Date, end: Date) {
        self.startDate = start
        if end < start {
            self.endDate = start
        } else {
            self.endDate = end
        }
        self.duration = self.endDate.timeIntervalSince(self.startDate)
    }
}
