import XCTest
import SwiftData
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteInitialization_defaultValues() {
        let note = Note(title: "Default Test Note")

        XCTAssertEqual(note.title, "Default Test Note")
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

    func testNoteInitialization_customValues() {
        let customId = UUID()
        let customDate = Date(timeIntervalSince1970: 1000)
        let customEmbedding: [Float] = [0.1, 0.2, 0.3]

        let note = Note(
            id: customId,
            title: "Custom Test Note",
            content: "This is some custom content.",
            createdAt: customDate,
            modifiedAt: customDate,
            embedding: customEmbedding
        )

        XCTAssertEqual(note.id, customId)
        XCTAssertEqual(note.title, "Custom Test Note")
        XCTAssertEqual(note.content, "This is some custom content.")
        XCTAssertEqual(note.createdAt, customDate)
        XCTAssertEqual(note.modifiedAt, customDate)
        XCTAssertEqual(note.embedding, customEmbedding)
    }

    func testNotePropertyMutability() {
        let note = Note(title: "Initial Title")

        note.title = "Updated Title"
        note.content = "Updated Content"

        let newDate = Date()
        note.modifiedAt = newDate
        note.embedding = [0.5, 0.5]

        XCTAssertEqual(note.title, "Updated Title")
        XCTAssertEqual(note.content, "Updated Content")
        XCTAssertEqual(note.modifiedAt, newDate)
        XCTAssertEqual(note.embedding, [0.5, 0.5])
    }
}
