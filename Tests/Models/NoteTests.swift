import XCTest
import SwiftData
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteInitialization() {
        let note = Note(title: "Default")

        XCTAssertEqual(note.title, "Default")
        XCTAssertEqual(note.content, "")
        XCTAssertNil(note.embedding)
        XCTAssertEqual(note.tags?.count ?? 0, 0)
        XCTAssertEqual(note.tasks?.count ?? 0, 0)
        XCTAssertEqual(note.references?.count ?? 0, 0)
        XCTAssertEqual(note.timeBlocks?.count ?? 0, 0)
        XCTAssertEqual(note.linkedNotes?.count ?? 0, 0)
        XCTAssertEqual(note.backlinks?.count ?? 0, 0)

        let customNote = Note(
            title: "Custom",
            content: "Hello World",
            embedding: [0.1, 0.2, 0.3]
        )

        XCTAssertEqual(customNote.title, "Custom")
        XCTAssertEqual(customNote.content, "Hello World")
        XCTAssertEqual(customNote.embedding, [0.1, 0.2, 0.3])
    }

    func testPropertyMutability() {
        let note = Note(title: "Initial")
        note.title = "Modified"
        note.content = "New content"

        XCTAssertEqual(note.title, "Modified")
        XCTAssertEqual(note.content, "New content")
    }
}
