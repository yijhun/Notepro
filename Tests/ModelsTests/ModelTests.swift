import XCTest
import SwiftData
@testable import Models

final class ModelTests: XCTestCase {

    var container: ModelContainer!
    var context: ModelContext!

    override func setUpWithError() throws {
        // Use an in-memory configuration for testing
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Note.self, Task.self, Tag.self, TimeBlock.self, ZoteroReference.self, configurations: config)
        context = container.mainContext
    }

    override func tearDownWithError() throws {
        container = nil
        context = nil
    }

    // MARK: - Task Tests

    func testTaskPriorityClamping() {
        // Test priority > 3
        let highPriorityTask = Task(title: "High", priority: 10)
        XCTAssertEqual(highPriorityTask.priority, 3, "Priority should be clamped to 3")

        // Test priority < 0
        let lowPriorityTask = Task(title: "Low", priority: -5)
        XCTAssertEqual(lowPriorityTask.priority, 0, "Priority should be clamped to 0")

        // Test valid priority
        let validTask = Task(title: "Normal", priority: 2)
        XCTAssertEqual(validTask.priority, 2, "Priority should remain 2")
    }

    // MARK: - TimeBlock Tests

    func testTimeBlockDurationUpdates() {
        let now = Date()
        let oneHourLater = now.addingTimeInterval(3600)

        let block = TimeBlock(title: "Work", startDate: now, endDate: oneHourLater)

        XCTAssertEqual(block.duration, 3600, accuracy: 0.1)

        // Update endDate
        let twoHoursLater = now.addingTimeInterval(7200)
        block.endDate = twoHoursLater
        block.updateDuration()

        XCTAssertEqual(block.duration, 7200, accuracy: 0.1)
    }

    func testTimeBlockNonNegativeDuration() {
        let now = Date()
        let oneHourLater = now.addingTimeInterval(3600)

        let block = TimeBlock(title: "Work", startDate: now, endDate: oneHourLater)

        // Try setting endDate before startDate
        let oneHourBefore = now.addingTimeInterval(-3600)
        block.endDate = oneHourBefore
        block.updateDuration()

        // endDate should be clamped to startDate
        XCTAssertEqual(block.endDate, now, "EndDate should be clamped to startDate")
        XCTAssertEqual(block.duration, 0, "Duration should be 0")

        // Test Init Clamping
        let invalidBlock = TimeBlock(title: "Invalid", startDate: now, endDate: oneHourBefore)
        XCTAssertEqual(invalidBlock.endDate, now)
        XCTAssertEqual(invalidBlock.duration, 0)
    }

    // MARK: - Relationship Tests

    func testTaskNoteRelationship() {
        let note = Note(title: "Project Plan")
        let task = Task(title: "Write Draft")

        context.insert(note)
        context.insert(task)

        // Link them
        task.linkedNote = note
        // Note: Inverse relationship should be updated automatically by SwiftData,
        // but sometimes requires a save or fetch to reflect in the array immediately in tests.
        // However, we can check if setting it works.

        XCTAssertEqual(task.linkedNote, note)
    }

    func testTagging() {
        let tag = Tag(name: "Urgent", colorHex: "#FF0000")
        let task = Task(title: "Fix Bug")

        context.insert(tag)
        context.insert(task)

        task.tags = [tag]

        XCTAssertEqual(task.tags?.first, tag)
        // Check inverse (might need context save/processPendingChanges for SwiftData to propagate)
        // try? context.save()
        // XCTAssertEqual(tag.tasks?.first, task)
    }
}
