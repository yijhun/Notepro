import Foundation
import SwiftData

@Model // Core schema for TimeBlock
final class TimeBlock: Taggable {
    var id: UUID = UUID()
    
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

    var duration: TimeInterval = 0
    var isAllDay: Bool = false
    
    // Relationships
    
    @Relationship(inverse: \Task.timeBlocks)
    var linkedTask: Task? = nil
    
    @Relationship(inverse: \Note.timeBlocks)
    var linkedNote: Note? = nil
    
    @Relationship(inverse: \Tag.timeBlocks)
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
        self.duration = endDate.timeIntervalSince(startDate)
        self.isAllDay = isAllDay
    }

    func recalculateDuration() {
        self.duration = endDate.timeIntervalSince(startDate)
    }
}
