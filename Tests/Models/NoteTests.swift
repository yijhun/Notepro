import XCTest
import Foundation
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteInitializationDefaultValues() {
        let note = Note()

        XCTAssertNotNil(note.id)
        XCTAssertEqual(note.title, "")
        XCTAssertEqual(note.content, "")
        XCTAssertNotNil(note.createdAt)
        XCTAssertNotNil(note.modifiedAt)
        XCTAssertNil(note.embedding)
    }

    func testNoteInitializationCustomValues() {
        let customID = UUID()
        let customDate = Date(timeIntervalSince1970: 1000)
        let note = Note(
            id: customID,
            title: "My Custom Title",
            content: "This is some custom content.",
            createdAt: customDate,
            modifiedAt: customDate,
            embedding: [0.1, 0.2, 0.3]
        )

        XCTAssertEqual(note.id, customID)
        XCTAssertEqual(note.title, "My Custom Title")
        XCTAssertEqual(note.content, "This is some custom content.")
        XCTAssertEqual(note.createdAt, customDate)
        XCTAssertEqual(note.modifiedAt, customDate)
        XCTAssertEqual(note.embedding, [0.1, 0.2, 0.3])
    }

    func testNotePropertyMutability() {
        let note = Note(title: "Initial Title", content: "Initial Content")

        note.title = "Updated Title"
        note.content = "Updated Content"

        XCTAssertEqual(note.title, "Updated Title")
        XCTAssertEqual(note.content, "Updated Content")
    }
}
