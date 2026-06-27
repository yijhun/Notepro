import XCTest
import Foundation
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteDefaultInitialization() {
        let title = "Test Note"
        let note = Note(title: title)

        XCTAssertEqual(note.title, title)
        XCTAssertEqual(note.content, "")
        XCTAssertNil(note.embedding)
        XCTAssertNil(note.tags)
        XCTAssertNil(note.references)
        XCTAssertNil(note.tasks)
        XCTAssertNil(note.timeBlocks)
        XCTAssertNil(note.linkedNotes)
        XCTAssertNil(note.backlinks)
    }

    func testNoteCustomInitialization() {
        let id = UUID()
        let title = "Custom Note"
        let content = "Custom Content"
        let date = Date()
        let embedding: [Float] = [0.1, 0.2, 0.3]

        let note = Note(
            id: id,
            title: title,
            content: content,
            createdAt: date,
            modifiedAt: date,
            embedding: embedding
        )

        XCTAssertEqual(note.id, id)
        XCTAssertEqual(note.title, title)
        XCTAssertEqual(note.content, content)
        XCTAssertEqual(note.createdAt, date)
        XCTAssertEqual(note.modifiedAt, date)
        XCTAssertEqual(note.embedding, embedding)
    }

    func testNotePropertyMutability() {
        let note = Note(title: "Initial Title")

        let newTitle = "Updated Title"
        note.title = newTitle
        XCTAssertEqual(note.title, newTitle)

        let newContent = "Updated Content"
        note.content = newContent
        XCTAssertEqual(note.content, newContent)

        let newEmbedding: [Float] = [0.5, 0.5, 0.5]
        note.embedding = newEmbedding
        XCTAssertEqual(note.embedding, newEmbedding)
    }
}
