import XCTest
import SwiftData
@testable import Models

final class ModelTests: XCTestCase {
    var container: ModelContainer!
    var context: ModelContext!

    override func setUp() async throws {
        let schema = Schema([
            Note.self,
            Task.self,
            TimeBlock.self,
            Tag.self,
            ZoteroReference.self
        ])
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: schema, configurations: [config])
        context = container.mainContext
    }

    override func tearDown() {
        container = nil
        context = nil
    }

    func testTimeBlockDurationConstraint() {
        let startDate = Date()
        let endDate = startDate.addingTimeInterval(-3600) // End date before start date

        // This simulates creating a TimeBlock where the end date is earlier than start
        let timeBlock = TimeBlock(title: "Test Block", startDate: startDate, endDate: endDate)

        // Assert endDate was clamped to startDate by the initializer
        XCTAssertEqual(timeBlock.endDate, startDate, "End date should be clamped to start date if it is earlier")
        XCTAssertEqual(timeBlock.duration, 0, "Duration should be 0")

        // Test setTimeRange with a valid future date
        let validFutureDate = startDate.addingTimeInterval(3600)
        timeBlock.setTimeRange(start: startDate, end: validFutureDate)
        XCTAssertEqual(timeBlock.duration, 3600, "Duration should be updated correctly")

        // Test setTimeRange with an invalid past date (regression test)
        let invalidPastDate = startDate.addingTimeInterval(-100)
        timeBlock.setTimeRange(start: startDate, end: invalidPastDate)

        // After setTimeRange, endDate should be clamped to startDate
        XCTAssertEqual(timeBlock.endDate, startDate, "End date should be clamped to start date on update")
        XCTAssertEqual(timeBlock.duration, 0, "Duration should be 0 after clamping")
    }

    func testTaskPriorityClamping() {
        let lowPriorityTask = Task(title: "Low", priority: -1)
        XCTAssertEqual(lowPriorityTask.priority, 0, "Priority < 0 should be clamped to 0")

        let highPriorityTask = Task(title: "High", priority: 10)
        XCTAssertEqual(highPriorityTask.priority, 3, "Priority > 3 should be clamped to 3")

        let validTask = Task(title: "Valid", priority: 2)
        XCTAssertEqual(validTask.priority, 2, "Valid priority should remain unchanged")
    }

    func testRelationships() {
        let note = Note(title: "Test Note")
        let tag = Tag(name: "Test Tag")

        // Manually link for test
        note.tags = [tag]

        // Insert into context
        context.insert(note)

        // Verify forward relationship
        XCTAssertEqual(note.tags?.first?.name, "Test Tag")
    }

    func testZoteroReferenceLinking() {
        let reference = ZoteroReference(zoteroID: "REF123", title: "SwiftData Guide")
        let note = Note(title: "Research Note")

        // Link reference to note
        // Since Note defines the inverse via @Relationship(inverse: \ZoteroReference.linkedNotes)
        // and Note has `references: [ZoteroReference]?`
        note.references = [reference]

        context.insert(note)

        XCTAssertEqual(note.references?.first?.zoteroID, "REF123")
    }
}
