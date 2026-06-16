import XCTest
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteDefaultInitialization() {
        let note = Note(title: "Default Test")

        XCTAssertEqual(note.title, "Default Test")
        XCTAssertEqual(note.content, "")
        XCTAssertNil(note.embedding)
        XCTAssertNil(note.tags)
        XCTAssertNil(note.references)
        XCTAssertNil(note.tasks)
        XCTAssertNil(note.timeBlocks)
        XCTAssertNil(note.linkedNotes)
        XCTAssertNil(note.backlinks)
    }

    func testNotePropertyMutability() {
        let note = Note(title: "Initial Title")
        note.title = "Updated Title"
        note.content = "New content"

        XCTAssertEqual(note.title, "Updated Title")
        XCTAssertEqual(note.content, "New content")
    }
}
