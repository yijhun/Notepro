import XCTest
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteInitializationWithDefaultValues() {
        let title = "Test Note"
        let note = Note(title: title)

        XCTAssertEqual(note.title, title)
        XCTAssertEqual(note.content, "")
        XCTAssertNotNil(note.id)
        XCTAssertNotNil(note.createdAt)
        XCTAssertNotNil(note.modifiedAt)
        XCTAssertNil(note.embedding)
        XCTAssertNil(note.tags)
        XCTAssertNil(note.references)
        XCTAssertNil(note.tasks)
        XCTAssertNil(note.timeBlocks)
        XCTAssertNil(note.linkedNotes)
        XCTAssertNil(note.backlinks)
    }

    func testNoteInitializationWithCustomValues() {
        let id = UUID()
        let title = "Custom Note"
        let content = "Custom Content"
        let date = Date(timeIntervalSince1970: 1000000)
        let embedding: [Float] = [0.1, 0.2, 0.3]

        let note = Note(id: id, title: title, content: content, createdAt: date, modifiedAt: date, embedding: embedding)

        XCTAssertEqual(note.id, id)
        XCTAssertEqual(note.title, title)
        XCTAssertEqual(note.content, content)
        XCTAssertEqual(note.createdAt, date)
        XCTAssertEqual(note.modifiedAt, date)
        XCTAssertEqual(note.embedding, embedding)
    }

    func testNotePropertyMutability() {
        let note = Note(title: "Initial Title")

        let newTitle = "Modified Title"
        let newContent = "Modified Content"
        let newDate = Date()
        let newEmbedding: [Float] = [0.5, 0.5]

        note.title = newTitle
        note.content = newContent
        note.modifiedAt = newDate
        note.embedding = newEmbedding

        XCTAssertEqual(note.title, newTitle)
        XCTAssertEqual(note.content, newContent)
        XCTAssertEqual(note.modifiedAt, newDate)
        XCTAssertEqual(note.embedding, newEmbedding)
    }
}
