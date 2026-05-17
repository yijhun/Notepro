import XCTest
import SwiftData
@testable import Candler

final class NoteTests: XCTestCase {
    func testNoteInitializationWithDefaults() {
        let note = Note(title: "Default Note")

        XCTAssertNotNil(note.id)
        XCTAssertEqual(note.title, "Default Note")
        XCTAssertEqual(note.content, "")
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
        let createdAt = Date(timeIntervalSince1970: 1000)
        let modifiedAt = Date(timeIntervalSince1970: 2000)
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
        let newDate = Date()
        note.modifiedAt = newDate
        let newEmbedding: [Float] = [0.4, 0.5, 0.6]
        note.embedding = newEmbedding

        XCTAssertEqual(note.title, "Updated Title")
        XCTAssertEqual(note.content, "Updated Content")
        XCTAssertEqual(note.modifiedAt, newDate)
        XCTAssertEqual(note.embedding, newEmbedding)
    }
}
