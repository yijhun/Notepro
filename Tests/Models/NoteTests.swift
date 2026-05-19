import XCTest
import SwiftData
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteInitializationWithDefaults() {
        let note = Note(title: "Test Note")

        XCTAssertEqual(note.title, "Test Note")
        XCTAssertEqual(note.content, "")
        XCTAssertNil(note.embedding)
        XCTAssertNil(note.tags)
    }

    func testNoteInitializationWithCustomValues() {
        let embedding: [Float] = [0.1, 0.2, 0.3]
        let note = Note(title: "Custom Note", content: "Some content", embedding: embedding)

        XCTAssertEqual(note.title, "Custom Note")
        XCTAssertEqual(note.content, "Some content")
        XCTAssertEqual(note.embedding, embedding)
    }

    func testNotePropertyMutability() {
        let note = Note(title: "Initial Title")
        note.title = "Updated Title"
        note.content = "Updated Content"
        note.embedding = [0.5, 0.5]

        XCTAssertEqual(note.title, "Updated Title")
        XCTAssertEqual(note.content, "Updated Content")
        XCTAssertEqual(note.embedding, [0.5, 0.5])
    }
}
