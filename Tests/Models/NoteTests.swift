import XCTest
import SwiftData
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteInitializationWithDefaults() {
        let note = Note(title: "Test Note")

        XCTAssertNotNil(note.id)
        XCTAssertEqual(note.title, "Test Note")
        XCTAssertEqual(note.content, "")
        XCTAssertNotNil(note.createdAt)
        XCTAssertNotNil(note.modifiedAt)
        XCTAssertNil(note.embedding)
        XCTAssertNil(note.embeddingData)
    }

    func testNoteInitializationWithCustomValues() {
        let id = UUID()
        let title = "Custom Note"
        let content = "Custom Content"
        let date = Date()
        let embedding: [Float] = [1.0, 2.0, 3.0]

        let note = Note(id: id, title: title, content: content, createdAt: date, modifiedAt: date, embedding: embedding)

        XCTAssertEqual(note.id, id)
        XCTAssertEqual(note.title, title)
        XCTAssertEqual(note.content, content)
        XCTAssertEqual(note.createdAt, date)
        XCTAssertEqual(note.modifiedAt, date)
        XCTAssertEqual(note.embedding, embedding)
        XCTAssertNotNil(note.embeddingData)
    }

    func testNotePropertyMutations() {
        let note = Note(title: "Initial Title")

        note.title = "Updated Title"
        XCTAssertEqual(note.title, "Updated Title")

        note.content = "New Content"
        XCTAssertEqual(note.content, "New Content")

        let newEmbedding: [Float] = [0.5, 0.5]
        note.embedding = newEmbedding
        XCTAssertEqual(note.embedding, newEmbedding)
        XCTAssertNotNil(note.embeddingData)

        note.embedding = nil
        XCTAssertNil(note.embedding)
        XCTAssertNil(note.embeddingData)
    }
}
