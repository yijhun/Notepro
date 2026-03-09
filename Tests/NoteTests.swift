import XCTest
import SwiftData
@testable import Models

@MainActor
final class NoteTests: XCTestCase {

    var container: ModelContainer!
    var context: ModelContext!

    override func setUpWithError() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Note.self, Tag.self, Task.self, TimeBlock.self, ZoteroReference.self, configurations: config)
        context = container.mainContext
    }

    override func tearDownWithError() throws {
        container = nil
        context = nil
    }

    func testNoteInitialization() throws {
        let title = "Test Note"
        let content = "This is a test note."
        let note = Note(title: title, content: content)

        context.insert(note)

        XCTAssertNotNil(note.id)
        XCTAssertEqual(note.title, title)
        XCTAssertEqual(note.content, content)
        XCTAssertNotNil(note.createdAt)
        XCTAssertNotNil(note.modifiedAt)
        XCTAssertNil(note.tags)
        XCTAssertNil(note.references)
        XCTAssertNil(note.tasks)
        XCTAssertNil(note.timeBlocks)
        XCTAssertNil(note.linkedNotes)
        XCTAssertNil(note.backlinks)
    }

    func testNoteTagRelationship() throws {
        let note = Note(title: "Tagged Note")
        let tag = Tag(name: "TestTag", colorHex: "#FF0000")

        context.insert(note)
        context.insert(tag)

        // Test adding tag
        note.tags = [tag]

        XCTAssertEqual(note.tags?.count, 1)
        XCTAssertEqual(note.tags?.first?.name, "TestTag")

        // Check inverse relationship
        XCTAssertEqual(tag.notes?.count, 1)
        XCTAssertEqual(tag.notes?.first?.title, "Tagged Note")

        // Test removing tag
        note.tags = []
        XCTAssertEqual(note.tags?.count, 0)
        XCTAssertEqual(tag.notes?.count, 0)
    }

    func testNoteTaskRelationship() throws {
        let note = Note(title: "Task Note")
        let task = Task(title: "Test Task")

        context.insert(note)
        context.insert(task)

        // Test adding task
        note.tasks = [task]

        XCTAssertEqual(note.tasks?.count, 1)
        XCTAssertEqual(task.linkedNote, note)

        // Test removing task
        note.tasks = []
        XCTAssertEqual(note.tasks?.count, 0)
        XCTAssertNil(task.linkedNote)
    }

    func testNoteTimeBlockRelationship() throws {
        let note = Note(title: "TimeBlock Note")
        let timeBlock = TimeBlock(title: "Focus", startDate: Date(), endDate: Date().addingTimeInterval(3600))

        context.insert(note)
        context.insert(timeBlock)

        // Test adding time block
        note.timeBlocks = [timeBlock]

        XCTAssertEqual(note.timeBlocks?.count, 1)
        XCTAssertEqual(timeBlock.linkedNote, note)

        // Test removing time block
        note.timeBlocks = []
        XCTAssertEqual(note.timeBlocks?.count, 0)
        XCTAssertNil(timeBlock.linkedNote)
    }

    func testNoteZoteroReferenceRelationship() throws {
        let note = Note(title: "Ref Note")
        let ref = ZoteroReference(zoteroID: "123", title: "Paper A")

        context.insert(note)
        context.insert(ref)

        // Test adding reference
        note.references = [ref]

        XCTAssertEqual(note.references?.count, 1)
        XCTAssertEqual(ref.linkedNotes?.count, 1)
        XCTAssertEqual(ref.linkedNotes?.first?.title, "Ref Note")

        // Test removing reference
        note.references = []
        XCTAssertEqual(note.references?.count, 0)
        XCTAssertEqual(ref.linkedNotes?.count, 0)
    }

    func testNoteLinking() throws {
        let noteA = Note(title: "Note A")
        let noteB = Note(title: "Note B")

        context.insert(noteA)
        context.insert(noteB)

        // A links to B
        noteA.linkedNotes = [noteB]

        XCTAssertEqual(noteA.linkedNotes?.count, 1)
        XCTAssertEqual(noteA.linkedNotes?.first, noteB)

        // Check backlinks
        XCTAssertEqual(noteB.backlinks?.count, 1)
        XCTAssertEqual(noteB.backlinks?.first, noteA)

        // Remove link
        noteA.linkedNotes = []
        XCTAssertEqual(noteA.linkedNotes?.count, 0)
        XCTAssertEqual(noteB.backlinks?.count, 0)
    }
}
