import XCTest
import SwiftData
@testable import Models

final class ModelTests: XCTestCase {
    var container: ModelContainer!
    var context: ModelContext!

    override func setUp() {
        super.setUp()
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let schema = Schema([Note.self, Task.self, TimeBlock.self, Tag.self, ZoteroReference.self])
        do {
            container = try ModelContainer(for: schema, configurations: [config])
            context = ModelContext(container)
        } catch {
            XCTFail("Failed to create in-memory model container: \(error)")
        }
    }

    override func tearDown() {
        container = nil
        context = nil
        super.tearDown()
    }

    func testNoteCreationAndRelationships() throws {
        let note1 = Note(title: "Main Note", content: "Content 1")
        let note2 = Note(title: "Linked Note", content: "Content 2")
        let tag = Tag(name: "TestTag", colorHex: "#FF0000")
        let task = Task(title: "Test Task")
        let zoteroRef = ZoteroReference(zoteroID: "12345", title: "Test Paper")

        context.insert(note1)
        context.insert(note2)
        context.insert(tag)
        context.insert(task)
        context.insert(zoteroRef)

        note1.tags = [tag]
        note1.tasks = [task]
        note1.references = [zoteroRef]
        note1.linkedNotes = [note2]

        try context.save()

        // Verify relationships
        XCTAssertEqual(note1.tags?.count, 1)
        XCTAssertEqual(note1.tasks?.count, 1)
        XCTAssertEqual(note1.references?.count, 1)
        XCTAssertEqual(note1.linkedNotes?.count, 1)

        // Test bidirectional inverse
        XCTAssertEqual(note2.backlinks?.count, 1)
        XCTAssertEqual(note2.backlinks?.first?.id, note1.id)
    }

    func testTaskPriorityClamping() {
        let lowPriorityTask = Task(title: "Low", priority: -1)
        XCTAssertEqual(lowPriorityTask.priority, 0)

        let highPriorityTask = Task(title: "High", priority: 10)
        XCTAssertEqual(highPriorityTask.priority, 3)

        let validTask = Task(title: "Valid", priority: 2)
        XCTAssertEqual(validTask.priority, 2)
    }

    func testTimeBlockDurationUpdate() {
        let start = Date()
        let end = start.addingTimeInterval(3600) // 1 hour
        let timeBlock = TimeBlock(title: "Work", startDate: start, endDate: end)

        XCTAssertEqual(timeBlock.duration, 3600)

        let newEnd = start.addingTimeInterval(7200) // 2 hours
        timeBlock.setTimeRange(start: start, end: newEnd)

        XCTAssertEqual(timeBlock.duration, 7200)
    }
}
