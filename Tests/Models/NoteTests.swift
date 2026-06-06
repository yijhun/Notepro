import XCTest
import SwiftData
@testable import Candler

final class NoteTests: XCTestCase {
    func testNoteInitializationDefaultValues() {
        let note = Note(title: "Test Note")

        XCTAssertEqual(note.title, "Test Note")
        XCTAssertEqual(note.content, "")
        XCTAssertNil(note.embedding)
        XCTAssertTrue(note.tags?.isEmpty ?? true)
        XCTAssertTrue(note.references?.isEmpty ?? true)
        XCTAssertTrue(note.tasks?.isEmpty ?? true)
        XCTAssertTrue(note.timeBlocks?.isEmpty ?? true)
        XCTAssertTrue(note.linkedNotes?.isEmpty ?? true)
        XCTAssertTrue(note.backlinks?.isEmpty ?? true)
    }

    func testNoteInitializationCustomValues() {
        let id = UUID()
        let title = "Custom Note"
        let content = "This is a custom note."
        let createdAt = Date(timeIntervalSince1970: 0)
        let modifiedAt = Date(timeIntervalSince1970: 1000)
        let embedding: [Float] = [0.1, 0.2, 0.3]

        let note = Note(
            id: id,
            title: title,
            content: content,
            createdAt: createdAt,
            modifiedAt: modifiedAt,
            embedding: embedding
        )

        XCTAssertEqual(note.id, id)
        XCTAssertEqual(note.title, title)
        XCTAssertEqual(note.content, content)
        XCTAssertEqual(note.createdAt, createdAt)
        XCTAssertEqual(note.modifiedAt, modifiedAt)
        XCTAssertEqual(note.embedding, embedding)
    }

    func testNotePropertyMutability() {
        let note = Note(title: "Initial Title")

        note.title = "Updated Title"
        note.content = "Updated Content"
        note.embedding = [0.5, 0.6]

        XCTAssertEqual(note.title, "Updated Title")
        XCTAssertEqual(note.content, "Updated Content")
        XCTAssertEqual(note.embedding, [0.5, 0.6])
    }
}
