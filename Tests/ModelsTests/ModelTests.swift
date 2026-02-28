import XCTest
import SwiftData
@testable import Models

@MainActor
final class ModelTests: XCTestCase {

    var container: ModelContainer!
    var context: ModelContext!

    override func setUp() {
        super.setUp()
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let schema = Schema([Note.self, Task.self, TimeBlock.self, Tag.self, ZoteroReference.self])
        do {
            container = try ModelContainer(for: schema, configurations: config)
            context = container.mainContext
        } catch {
            XCTFail("Failed to create in-memory ModelContainer: \(error)")
        }
    }

    override func tearDown() {
        container = nil
        context = nil
        super.tearDown()
    }

    func testNoteInitialization() {
        let note = Note(title: "Test Note", content: "Test Content")
        context.insert(note)

        XCTAssertEqual(note.title, "Test Note")
        XCTAssertEqual(note.content, "Test Content")
        XCTAssertNotNil(note.id)
    }

    func testTaskPriorityClamping() {
        let task1 = Task(title: "Low Priority", priority: -1) // Should clamp to 0
        let task2 = Task(title: "High Priority", priority: 5) // Should clamp to 3
        let task3 = Task(title: "Normal Priority", priority: 2) // Should remain 2

        context.insert(task1)
        context.insert(task2)
        context.insert(task3)

        XCTAssertEqual(task1.priority, 0)
        XCTAssertEqual(task2.priority, 3)
        XCTAssertEqual(task3.priority, 2)

        task3.setPriority(6)
        XCTAssertEqual(task3.priority, 3)

        task3.setPriority(-2)
        XCTAssertEqual(task3.priority, 0)
    }

    func testTimeBlockDuration() {
        let start = Date()
        let end = start.addingTimeInterval(3600) // 1 hour
        let timeBlock = TimeBlock(title: "Focus Work", startDate: start, endDate: end)

        context.insert(timeBlock)

        XCTAssertEqual(timeBlock.duration, 3600)

        let newEnd = start.addingTimeInterval(7200) // 2 hours
        timeBlock.setTimeRange(start: start, end: newEnd)

        XCTAssertEqual(timeBlock.duration, 7200)
    }

    func testTagRelationships() {
        let tag = Tag(name: "Important")
        let note = Note(title: "Important Note")
        let task = Task(title: "Important Task")

        context.insert(tag)
        context.insert(note)
        context.insert(task)

        note.tags = [tag]
        task.tags = [tag]

        try? context.save()

        XCTAssertTrue(note.tags?.contains(where: { $0.id == tag.id }) == true)
        XCTAssertTrue(task.tags?.contains(where: { $0.id == tag.id }) == true)

        XCTAssertTrue(tag.notes?.contains(where: { $0.id == note.id }) == true)
        XCTAssertTrue(tag.tasks?.contains(where: { $0.id == task.id }) == true)
    }

    func testBidirectionalNoteLinks() {
        let noteA = Note(title: "Note A")
        let noteB = Note(title: "Note B")

        context.insert(noteA)
        context.insert(noteB)

        noteA.linkedNotes = [noteB]

        try? context.save()

        XCTAssertTrue(noteA.linkedNotes?.contains(where: { $0.id == noteB.id }) == true)
        XCTAssertTrue(noteB.backlinks?.contains(where: { $0.id == noteA.id }) == true)
    }

    func testOneToManyRelationships() {
        let task1 = Task(title: "Task 1")
        let task2 = Task(title: "Task 2")
        let note = Note(title: "Parent Note")

        context.insert(task1)
        context.insert(task2)
        context.insert(note)

        task1.linkedNote = note
        task2.linkedNote = note

        try? context.save()

        XCTAssertTrue(note.tasks?.contains(where: { $0.id == task1.id }) == true)
        XCTAssertTrue(note.tasks?.contains(where: { $0.id == task2.id }) == true)
    }
}
