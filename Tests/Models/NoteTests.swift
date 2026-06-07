import XCTest
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteInitializationWithDefaults() {
        let note = Note(title: "Default Test")

        XCTAssertEqual(note.title, "Default Test")
        XCTAssertEqual(note.content, "")
        XCTAssertNil(note.embedding)
        XCTAssertNotNil(note.id)
        XCTAssertNotNil(note.createdAt)
        XCTAssertNotNil(note.modifiedAt)
    }

    func testNoteInitializationWithCustomValues() {
        let id = UUID()
        let createdAt = Date(timeIntervalSince1970: 1000)
        let modifiedAt = Date(timeIntervalSince1970: 2000)
        let embedding: [Float] = [0.1, 0.2, 0.3]

        let note = Note(
            id: id,
            title: "Custom Title",
            content: "Custom Content",
            createdAt: createdAt,
            modifiedAt: modifiedAt,
            embedding: embedding
        )

        XCTAssertEqual(note.id, id)
        XCTAssertEqual(note.title, "Custom Title")
        XCTAssertEqual(note.content, "Custom Content")
        XCTAssertEqual(note.createdAt, createdAt)
        XCTAssertEqual(note.modifiedAt, modifiedAt)
        XCTAssertEqual(note.embedding, embedding)
    }

    func testNotePropertyMutability() {
        let note = Note(title: "Initial Title")

        let newTitle = "Updated Title"
        let newContent = "Updated Content"
        let newModifiedAt = Date()
        let newEmbedding: [Float] = [0.5, 0.6]

        note.title = newTitle
        note.content = newContent
        note.modifiedAt = newModifiedAt
        note.embedding = newEmbedding

        XCTAssertEqual(note.title, newTitle)
        XCTAssertEqual(note.content, newContent)
        XCTAssertEqual(note.modifiedAt, newModifiedAt)
        XCTAssertEqual(note.embedding, newEmbedding)
    }
}
