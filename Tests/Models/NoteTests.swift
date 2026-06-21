import XCTest
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteInitialization_DefaultValues() {
        let note = Note(title: "Default Title")

        XCTAssertNotNil(note.id)
        XCTAssertEqual(note.title, "Default Title")
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
            title: "Custom Title",
            content: "Custom Content",
            createdAt: customDate,
            modifiedAt: customDate,
            embedding: customEmbedding
        )

        XCTAssertEqual(note.id, customID)
        XCTAssertEqual(note.title, "Custom Title")
        XCTAssertEqual(note.content, "Custom Content")
        XCTAssertEqual(note.createdAt, customDate)
        XCTAssertEqual(note.modifiedAt, customDate)
        XCTAssertEqual(note.embedding, customEmbedding)
    }

    func testNotePropertyMutability() {
        let note = Note(title: "Initial Title")

        note.title = "Updated Title"
        note.content = "Updated Content"
        note.embedding = [0.5, 0.6]

        XCTAssertEqual(note.title, "Updated Title")
        XCTAssertEqual(note.content, "Updated Content")
        XCTAssertEqual(note.embedding, [0.5, 0.6])
    }
}
