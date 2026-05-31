import XCTest
import SwiftData
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteDefaultInitialization() {
        let note = Note(title: "Default Note")

        XCTAssertNotNil(note.id)
        XCTAssertEqual(note.title, "Default Note")
        XCTAssertEqual(note.content, "")
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

    func testNoteCustomInitialization() {
        let customID = UUID()
        let customCreatedAt = Date(timeIntervalSince1970: 1000)
        let customModifiedAt = Date(timeIntervalSince1970: 2000)
        let customEmbedding: [Float] = [0.1, 0.2, 0.3]

        let note = Note(
            id: customID,
            title: "Custom Note",
            content: "Some content",
            createdAt: customCreatedAt,
            modifiedAt: customModifiedAt,
            embedding: customEmbedding
        )

        XCTAssertEqual(note.id, customID)
        XCTAssertEqual(note.title, "Custom Note")
        XCTAssertEqual(note.content, "Some content")
        XCTAssertEqual(note.createdAt, customCreatedAt)
        XCTAssertEqual(note.modifiedAt, customModifiedAt)
        XCTAssertEqual(note.embedding, customEmbedding)
    }

    func testNotePropertyMutability() {
        let note = Note(title: "Initial Title")
        note.title = "Updated Title"
        note.content = "Updated Content"

        XCTAssertEqual(note.title, "Updated Title")
        XCTAssertEqual(note.content, "Updated Content")
    }

    func testNoteEmbeddingConversion() {
        let note = Note(title: "Embedding Test")
        let embedding: [Float] = [0.5, 0.6, 0.7]

        note.embedding = embedding

        XCTAssertNotNil(note.embeddingData)
        XCTAssertEqual(note.embedding, embedding)
    }
}
