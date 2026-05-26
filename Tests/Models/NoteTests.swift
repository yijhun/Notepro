import XCTest
import SwiftData
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteInitializationDefaultValues() {
        let note = Note()
        XCTAssertNotNil(note.id)
        XCTAssertEqual(note.title, "")
        XCTAssertEqual(note.content, "")
        // Dates should be approximately now
        XCTAssertTrue(abs(note.createdAt.timeIntervalSinceNow) < 5)
        XCTAssertTrue(abs(note.modifiedAt.timeIntervalSinceNow) < 5)
        XCTAssertNil(note.embedding)
        XCTAssertNil(note.embeddingData)
    }

    func testNoteInitializationCustomValues() {
        let id = UUID()
        let createdAt = Date().addingTimeInterval(-3600)
        let modifiedAt = Date()
        let embedding: [Float] = [0.1, 0.2, 0.3]

        let note = Note(id: id, title: "Test Title", content: "Test Content", createdAt: createdAt, modifiedAt: modifiedAt, embedding: embedding)

        XCTAssertEqual(note.id, id)
        XCTAssertEqual(note.title, "Test Title")
        XCTAssertEqual(note.content, "Test Content")
        XCTAssertEqual(note.createdAt, createdAt)
        XCTAssertEqual(note.modifiedAt, modifiedAt)
        XCTAssertEqual(note.embedding, embedding)
    }

    func testNotePropertyMutability() {
        let note = Note(title: "Initial Title")

        note.title = "Updated Title"
        XCTAssertEqual(note.title, "Updated Title")

        note.content = "Updated Content"
        XCTAssertEqual(note.content, "Updated Content")

        let newEmbedding: [Float] = [0.4, 0.5, 0.6]
        note.embedding = newEmbedding
        XCTAssertEqual(note.embedding, newEmbedding)
        XCTAssertNotNil(note.embeddingData)
    }
}
