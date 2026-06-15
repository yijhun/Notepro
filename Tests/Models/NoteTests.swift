import XCTest
import SwiftData
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
        let customId = UUID()
        let customTitle = "My Custom Note"
        let customContent = "This is the content."
        let customDate = Date(timeIntervalSince1970: 0)
        let customEmbedding: [Float] = [0.1, 0.2, 0.3]

        let note = Note(
            id: customId,
            title: customTitle,
            content: customContent,
            createdAt: customDate,
            modifiedAt: customDate,
            embedding: customEmbedding
        )

        XCTAssertEqual(note.id, customId)
        XCTAssertEqual(note.title, customTitle)
        XCTAssertEqual(note.content, customContent)
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

        XCTAssertEqual(note.title, "Updated Title")
        XCTAssertEqual(note.content, "Updated Content")
        XCTAssertEqual(note.modifiedAt, newDate)
    }
}
