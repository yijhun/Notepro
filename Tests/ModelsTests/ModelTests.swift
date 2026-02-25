import XCTest
import SwiftData
@testable import Models

final class ModelTests: XCTestCase {

    @MainActor
    func testModelRelationships() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Note.self, Task.self, Tag.self, TimeBlock.self, ZoteroReference.self, configurations: config)
        let context = container.mainContext

        // Create Tags
        let tag1 = Tag(name: "Research", colorHex: "#FF0000")
        context.insert(tag1)

        // Create Note
        let note1 = Note(title: "Thesis Ideas", content: "Some ideas...")
        context.insert(note1)

        // Link Note and Tag
        note1.tags = [tag1]

        // Create Task
        let task1 = Task(title: "Read papers", priority: 2)
        context.insert(task1)

        // Link Task to Note
        task1.linkedNote = note1

        // Verify relationships
        XCTAssertEqual(note1.tags?.first?.name, "Research")
        XCTAssertEqual(tag1.notes?.first?.title, "Thesis Ideas")
        XCTAssertEqual(task1.linkedNote?.title, "Thesis Ideas")
        XCTAssertEqual(note1.tasks?.first?.title, "Read papers")

        // Create TimeBlock
        let now = Date()
        let hourLater = now.addingTimeInterval(3600)
        let timeBlock = TimeBlock(title: "Deep Work", startDate: now, endDate: hourLater)
        context.insert(timeBlock)

        // Link TimeBlock to Task
        timeBlock.linkedTask = task1

        XCTAssertEqual(timeBlock.linkedTask?.title, "Read papers")
        XCTAssertEqual(task1.timeBlocks?.first?.title, "Deep Work")

        // Verify TimeBlock duration logic
        // Allow for small floating point differences
        XCTAssertEqual(timeBlock.duration, 3600, accuracy: 0.1)

        // Update duration
        let twoHoursLater = now.addingTimeInterval(7200)
        timeBlock.updateDuration(newEndDate: twoHoursLater)
        XCTAssertEqual(timeBlock.duration, 7200, accuracy: 0.1)

        // Test priority clamping
        let task2 = Task(title: "High Priority", priority: 10)
        XCTAssertEqual(task2.priority, 3)

        let task3 = Task(title: "Low Priority", priority: -5)
        XCTAssertEqual(task3.priority, 0)
    }
}
