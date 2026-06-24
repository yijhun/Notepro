import XCTest
import SwiftData
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteInitializationWithDefaultValues() {
        let note = Note()

        XCTAssertNotNil(note.id)
        XCTAssertEqual(note.title, "")
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
        let customID = UUID()
        let customDate = Date(timeIntervalSince1970: 1000000)
        let note = Note(
            id: customID,
            title: "Test Note",
            content: "This is a test content.",
            createdAt: customDate,
            modifiedAt: customDate,
            embedding: [0.1, 0.2, 0.3]
        )

        XCTAssertEqual(note.id, customID)
        XCTAssertEqual(note.title, "Test Note")
        XCTAssertEqual(note.content, "This is a test content.")
        XCTAssertEqual(note.createdAt, customDate)
        XCTAssertEqual(note.modifiedAt, customDate)
        XCTAssertEqual(note.embedding, [0.1, 0.2, 0.3])
    }

    func testNotePropertyMutability() {
        let note = Note()

        // Mutate properties
        note.title = "Updated Title"
        note.content = "Updated Content"
        note.embedding = [0.5, 0.5]

        XCTAssertEqual(note.title, "Updated Title")
        XCTAssertEqual(note.content, "Updated Content")
        XCTAssertEqual(note.embedding, [0.5, 0.5])
    }
}
