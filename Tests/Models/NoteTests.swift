import XCTest
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteInitializationWithDefaults() {
        let note = Note(title: "Default Note")

        XCTAssertNotNil(note.id)
        XCTAssertEqual(note.title, "Default Note")
        XCTAssertEqual(note.content, "")
        XCTAssertNotNil(note.createdAt)
        XCTAssertNotNil(note.modifiedAt)
        XCTAssertNil(note.embedding)
    }

    func testNoteInitializationWithCustomValues() {
        let customId = UUID()
        let customDate = Date(timeIntervalSince1970: 1000)
        let customEmbedding: [Float] = [0.1, 0.2, 0.3]

        let note = Note(
            id: customId,
            title: "Custom Note",
            content: "This is some custom content.",
            createdAt: customDate,
            modifiedAt: customDate,
            embedding: customEmbedding
        )

        XCTAssertEqual(note.id, customId)
        XCTAssertEqual(note.title, "Custom Note")
        XCTAssertEqual(note.content, "This is some custom content.")
        XCTAssertEqual(note.createdAt, customDate)
        XCTAssertEqual(note.modifiedAt, customDate)
        XCTAssertEqual(note.embedding, customEmbedding)
    }

    func testNotePropertyMutability() {
        let note = Note(title: "Initial Title")

        note.title = "Updated Title"
        note.content = "Updated content."
        let newDate = Date()
        note.modifiedAt = newDate
        note.embedding = [0.5, 0.6]

        XCTAssertEqual(note.title, "Updated Title")
        XCTAssertEqual(note.content, "Updated content.")
        XCTAssertEqual(note.modifiedAt, newDate)
        XCTAssertEqual(note.embedding, [0.5, 0.6])
    }
}
