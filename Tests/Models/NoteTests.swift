import XCTest
import Foundation
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteInitializationWithDefaults() {
        let note = Note(title: "Default Title")

        XCTAssertNotNil(note.id, "ID should be auto-generated")
        XCTAssertEqual(note.title, "Default Title", "Title should match the input")
        XCTAssertEqual(note.content, "", "Content should be empty by default")
        XCTAssertNotNil(note.createdAt, "CreatedAt should be auto-generated")
        XCTAssertNotNil(note.modifiedAt, "ModifiedAt should be auto-generated")
        XCTAssertNil(note.embedding, "Embedding should be nil by default")

        XCTAssertNil(note.tags, "Tags relationship should be nil by default")
        XCTAssertNil(note.references, "References relationship should be nil by default")
        XCTAssertNil(note.tasks, "Tasks relationship should be nil by default")
        XCTAssertNil(note.timeBlocks, "TimeBlocks relationship should be nil by default")
        XCTAssertNil(note.linkedNotes, "LinkedNotes relationship should be nil by default")
        XCTAssertNil(note.backlinks, "Backlinks relationship should be nil by default")
    }

    func testNoteInitializationWithCustomValues() {
        let customID = UUID()
        let customCreatedAt = Date(timeIntervalSince1970: 1000)
        let customModifiedAt = Date(timeIntervalSince1970: 2000)
        let customEmbedding: [Float] = [0.1, 0.2, 0.3]

        let note = Note(
            id: customID,
            title: "Custom Title",
            content: "Custom Content",
            createdAt: customCreatedAt,
            modifiedAt: customModifiedAt,
            embedding: customEmbedding
        )

        XCTAssertEqual(note.id, customID, "ID should match the custom input")
        XCTAssertEqual(note.title, "Custom Title", "Title should match the custom input")
        XCTAssertEqual(note.content, "Custom Content", "Content should match the custom input")
        XCTAssertEqual(note.createdAt, customCreatedAt, "CreatedAt should match the custom input")
        XCTAssertEqual(note.modifiedAt, customModifiedAt, "ModifiedAt should match the custom input")
        XCTAssertEqual(note.embedding, customEmbedding, "Embedding should match the custom input")
    }

    func testNotePropertyMutability() {
        let note = Note(title: "Initial Title")

        note.title = "Updated Title"
        XCTAssertEqual(note.title, "Updated Title", "Title should be mutable")

        note.content = "Updated Content"
        XCTAssertEqual(note.content, "Updated Content", "Content should be mutable")

        let newDate = Date()
        note.modifiedAt = newDate
        XCTAssertEqual(note.modifiedAt, newDate, "ModifiedAt should be mutable")

        let newEmbedding: [Float] = [0.5, 0.6]
        note.embedding = newEmbedding
        XCTAssertEqual(note.embedding, newEmbedding, "Embedding should be mutable")
    }
}
