import XCTest
import SwiftData
@testable import Models

final class ModelTests: XCTestCase {
    var container: ModelContainer!
    var context: ModelContext!

    override func setUp() {
        super.setUp()
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        do {
            container = try ModelContainer(for: Note.self, Task.self, TimeBlock.self, Tag.self, ZoteroReference.self, configurations: config)
            context = ModelContext(container)
        } catch {
            XCTFail("Failed to create ModelContainer: \(error)")
        }
    }

    override func tearDown() {
        container = nil
        context = nil
        super.tearDown()
    }

    func testNoteCreation() throws {
        let note = Note(title: "Test Note", content: "This is a test.")
        context.insert(note)

        let descriptor = FetchDescriptor<Note>()
        let notes = try context.fetch(descriptor)

        XCTAssertEqual(notes.count, 1)
        XCTAssertEqual(notes.first?.title, "Test Note")
    }

    func testTagRelationship() throws {
        let note = Note(title: "Tagged Note")
        let tag = Tag(name: "Important")

        note.tags = [tag]
        context.insert(note)

        // Since it's a relationship, saving note should save tag (cascading inserts might happen or need explicit insert depending on SwiftData version, but usually inserting the parent inserts the child if it's new).
        // Safest is to insert both or let the relationship handle it.
        // Let's check.

        let fetchedNote = try context.fetch(FetchDescriptor<Note>()).first
        XCTAssertEqual(fetchedNote?.tags?.count, 1)
        XCTAssertEqual(fetchedNote?.tags?.first?.name, "Important")

        // Check inverse
        let fetchedTag = fetchedNote?.tags?.first
        XCTAssertEqual(fetchedTag?.notes?.count, 1)
        XCTAssertEqual(fetchedTag?.notes?.first?.title, "Tagged Note")
    }

    func testTimeBlockDuration() throws {
        let now = Date()
        let later = now.addingTimeInterval(3600) // 1 hour later

        let block = TimeBlock(title: "Work Session", startDate: now, endDate: later)
        context.insert(block)

        XCTAssertEqual(block.duration, 3600)

        // Test update
        let evenLater = now.addingTimeInterval(7200) // 2 hours later
        block.endDate = evenLater
        block.recalculateDuration()

        XCTAssertEqual(block.duration, 7200)
    }

    func testTaskPriority() throws {
        let task = Task(title: "High Priority Task", priority: 3)
        context.insert(task)

        let fetchedTask = try context.fetch(FetchDescriptor<Task>()).first
        XCTAssertEqual(fetchedTask?.priority, 3)
    }

    func testZoteroReference() throws {
        let ref = ZoteroReference(zoteroID: "12345", title: "SwiftData Guide", authors: ["Apple", "Community"])
        context.insert(ref)

        let fetchedRef = try context.fetch(FetchDescriptor<ZoteroReference>()).first
        XCTAssertEqual(fetchedRef?.authors.count, 2)
        XCTAssertTrue(fetchedRef?.authors.contains("Apple") ?? false)
    }

    func testBidirectionalLinking() throws {
        let noteA = Note(title: "Note A")
        let noteB = Note(title: "Note B")

        context.insert(noteA)
        context.insert(noteB)

        noteA.linkedNotes = [noteB]

        // Verify A -> B
        XCTAssertEqual(noteA.linkedNotes?.count, 1)
        XCTAssertEqual(noteA.linkedNotes?.first?.title, "Note B")

        // Verify B -> A (backlink)
        // Note: Relationship updates might require a save or context process pending changes.
        try context.save()

        XCTAssertEqual(noteB.backlinks?.count, 1)
        XCTAssertEqual(noteB.backlinks?.first?.title, "Note A")
    }
}
