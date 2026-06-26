import XCTest
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteInitialization_WithDefaultValues() {
        let note = Note()

        XCTAssertNotNil(note.id)
        XCTAssertEqual(note.title, "")
        XCTAssertEqual(note.content, "")
        XCTAssertNotNil(note.createdAt)
        XCTAssertNotNil(note.modifiedAt)
        XCTAssertNil(note.embedding)
    }

    func testNoteInitialization_WithCustomValues() {
        let customID = UUID()
        let customDate = Date()
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
        let note = Note()

        note.title = "Updated Title"
        note.content = "Updated Content"
        note.embedding = [0.5, 0.6]

        XCTAssertEqual(note.title, "Updated Title")
        XCTAssertEqual(note.content, "Updated Content")
        XCTAssertEqual(note.embedding, [0.5, 0.6])
    }
}
