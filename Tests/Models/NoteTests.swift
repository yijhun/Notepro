import XCTest
import SwiftData
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteInitializationWithDefaults() {
        let note = Note(title: "Test Note")

        XCTAssertEqual(note.title, "Test Note")
        XCTAssertEqual(note.content, "")
        XCTAssertNotNil(note.id)
        XCTAssertNotNil(note.createdAt)
        XCTAssertNotNil(note.modifiedAt)
        XCTAssertNil(note.embeddingData)
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
        let title = "Advanced SwiftData"
        let content = "Learning @Model and relationships"
        let createdAt = Date(timeIntervalSince1970: 0)
        let modifiedAt = Date(timeIntervalSince1970: 100)
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
        XCTAssertEqual(note.title, "Initial Title")

        note.title = "Updated Title"
        XCTAssertEqual(note.title, "Updated Title")

        note.content = "New Content"
        XCTAssertEqual(note.content, "New Content")

        let newDate = Date()
        note.modifiedAt = newDate
        XCTAssertEqual(note.modifiedAt, newDate)

        let newEmbedding: [Float] = [1.0, 2.0]
        note.embedding = newEmbedding
        XCTAssertEqual(note.embedding, newEmbedding)
    }
}
