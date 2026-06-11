import XCTest
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteInitialization_DefaultValues() {
        let note = Note()

        XCTAssertNotNil(note.id)
        XCTAssertEqual(note.title, "")
        XCTAssertEqual(note.content, "")
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

    func testNoteInitialization_CustomValues() {
        let customID = UUID()
        let customDate = Date(timeIntervalSince1970: 1000)
        let customEmbedding: [Float] = [0.1, 0.2, 0.3]

        let note = Note(
            id: customID,
            title: "Test Note",
            content: "Test Content",
            createdAt: customDate,
            modifiedAt: customDate,
            embedding: customEmbedding
        )

        XCTAssertEqual(note.id, customID)
        XCTAssertEqual(note.title, "Test Note")
        XCTAssertEqual(note.content, "Test Content")
        XCTAssertEqual(note.createdAt, customDate)
        XCTAssertEqual(note.modifiedAt, customDate)
        XCTAssertEqual(note.embedding, customEmbedding)
    }

    func testNotePropertyMutability() {
        let note = Note()

        note.title = "Updated Title"
        XCTAssertEqual(note.title, "Updated Title")

        note.content = "Updated Content"
        XCTAssertEqual(note.content, "Updated Content")

        let newDate = Date()
        note.modifiedAt = newDate
        XCTAssertEqual(note.modifiedAt, newDate)

        note.embedding = [0.5, 0.5]
        XCTAssertEqual(note.embedding, [0.5, 0.5])
    }
}
