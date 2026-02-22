import Foundation
import SwiftData

@Model
public final class TimeBlock: Taggable {
    @Attribute(.unique) public var id: UUID
    
    // For syncing with Google Calendar
    @Attribute(.unique) public var googleEventID: String?
    
    public var title: String
    public var startDate: Date
    public var endDate: Date

    /// Cached duration in seconds.
    /// This should be updated whenever `startDate` or `endDate` changes.
    public var duration: TimeInterval

    public var isAllDay: Bool
    
    // Relationships
    
    // Optional link to a Task (e.g. "Work on Thesis")
    @Relationship(inverse: \Task.timeBlocks)
    public var linkedTask: Task?
    
    // Optional link to a Note (e.g. "Read Paper X")
    @Relationship(inverse: \Note.timeBlocks)
    public var linkedNote: Note?
    
    // Tags for categorization (e.g. "Deep Work", "Admin")
    @Relationship(inverse: \Tag.timeBlocks)
    public var tags: [Tag]?
    
    public init(
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
        self.duration = endDate.timeIntervalSince(startDate)
        self.isAllDay = isAllDay
    }
}
