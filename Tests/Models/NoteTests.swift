import XCTest
import SwiftData
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteInitializationDefaultValues() {
        let note = Note(title: "Test Note")

        XCTAssertEqual(note.title, "Test Note")
        XCTAssertEqual(note.content, "")
        XCTAssertNil(note.embedding)
        XCTAssertNil(note.embeddingData)
        XCTAssertNotNil(note.id)
        XCTAssertNotNil(note.createdAt)
        XCTAssertNotNil(note.modifiedAt)
    }

    func testNoteInitializationCustomValues() {
        let id = UUID()
        let title = "My Custom Note"
        let content = "Some content here"
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
        XCTAssertNotNil(note.embeddingData)
    }

    func testNotePropertyMutability() {
        let note = Note(title: "Initial Title")
        note.title = "Updated Title"
        note.content = "New Content"

        let now = Date()
        note.modifiedAt = now

        XCTAssertEqual(note.title, "Updated Title")
        XCTAssertEqual(note.content, "New Content")
        XCTAssertEqual(note.modifiedAt, now)

        note.embedding = [0.5, 0.6]
        XCTAssertEqual(note.embedding, [0.5, 0.6])
    }
}
