import XCTest
import SwiftData
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteInitialization_DefaultValues() {
        let note = Note(title: "Test Title")

        XCTAssertEqual(note.title, "Test Title")
        XCTAssertEqual(note.content, "")
        XCTAssertNil(note.embedding)
        XCTAssertNil(note.tags)
        XCTAssertNil(note.references)
        XCTAssertNil(note.tasks)
        XCTAssertNil(note.timeBlocks)
        XCTAssertNil(note.linkedNotes)
        XCTAssertNil(note.backlinks)
    }

    func testNoteInitialization_CustomValues() {
        let id = UUID()
        let title = "Custom Note"
        let content = "Custom Content"
        let date = Date()
        let embedding: [Float] = [0.1, 0.2, 0.3]

        let note = Note(id: id, title: title, content: content, createdAt: date, modifiedAt: date, embedding: embedding)

        XCTAssertEqual(note.id, id)
        XCTAssertEqual(note.title, title)
        XCTAssertEqual(note.content, content)
        XCTAssertEqual(note.createdAt, date)
        XCTAssertEqual(note.modifiedAt, date)
        XCTAssertEqual(note.embedding, embedding)
    }

    func testNotePropertyMutability() {
        let note = Note(title: "Initial Title")
        XCTAssertEqual(note.title, "Initial Title")

        note.title = "Updated Title"
        note.content = "New Content"

        XCTAssertEqual(note.title, "Updated Title")
        XCTAssertEqual(note.content, "New Content")
    }
}
