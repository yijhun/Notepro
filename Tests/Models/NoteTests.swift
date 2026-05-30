import XCTest
import Foundation
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteInitializationWithDefaults() {
        let note = Note()

        XCTAssertNotNil(note.id)
        XCTAssertEqual(note.title, "")
        XCTAssertEqual(note.content, "")
        XCTAssertNotNil(note.createdAt)
        XCTAssertNotNil(note.modifiedAt)
        XCTAssertNil(note.embedding)
    }

    func testNoteInitializationWithCustomValues() {
        let customID = UUID()
        let customDate = Date(timeIntervalSince1970: 1000)
        let note = Note(
            id: customID,
            title: "Test Title",
            content: "Test Content",
            createdAt: customDate,
            modifiedAt: customDate,
            embedding: [0.1, 0.2, 0.3]
        )

        XCTAssertEqual(note.id, customID)
        XCTAssertEqual(note.title, "Test Title")
        XCTAssertEqual(note.content, "Test Content")
        XCTAssertEqual(note.createdAt, customDate)
        XCTAssertEqual(note.modifiedAt, customDate)
        XCTAssertEqual(note.embedding, [0.1, 0.2, 0.3])
    }

    func testNotePropertyMutability() {
        let note = Note()

        note.title = "New Title"
        note.content = "New Content"

        XCTAssertEqual(note.title, "New Title")
        XCTAssertEqual(note.content, "New Content")
    }
}
