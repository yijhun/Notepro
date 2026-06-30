import XCTest
import SwiftData
@testable import Candler

final class NoteTests: XCTestCase {
    func testDefaultInitialization() {
        let note = Note(title: "Default Note")

        XCTAssertNotNil(note.id)
        XCTAssertEqual(note.title, "Default Note")
        XCTAssertEqual(note.content, "")
        XCTAssertNotNil(note.createdAt)
        XCTAssertNotNil(note.modifiedAt)
        XCTAssertNil(note.embedding)
        XCTAssertNil(note.tags)
        XCTAssertNil(note.references)
        XCTAssertNil(note.tasks)
        XCTAssertNil(note.timeBlocks)
        XCTAssertNil(note.linkedNotes)
        XCTAssertNil(note.backlinks)
    }

    func testCustomInitialization() {
        let id = UUID()
        let customDate = Date(timeIntervalSince1970: 1000)
        let note = Note(id: id, title: "Custom Note", content: "Custom Content", createdAt: customDate, modifiedAt: customDate, embedding: [0.1, 0.2, 0.3])

        XCTAssertEqual(note.id, id)
        XCTAssertEqual(note.title, "Custom Note")
        XCTAssertEqual(note.content, "Custom Content")
        XCTAssertEqual(note.createdAt, customDate)
        XCTAssertEqual(note.modifiedAt, customDate)
        XCTAssertEqual(note.embedding, [0.1, 0.2, 0.3])
    }

    func testPropertyMutability() {
        let note = Note(title: "Test Note")

        let newTitle = "Updated Note"
        note.title = newTitle
        XCTAssertEqual(note.title, newTitle)

        let newContent = "Updated Content"
        note.content = newContent
        XCTAssertEqual(note.content, newContent)

        let newDate = Date()
        note.modifiedAt = newDate
        XCTAssertEqual(note.modifiedAt, newDate)

        let newEmbedding: [Float] = [0.5, 0.5]
        note.embedding = newEmbedding
        XCTAssertEqual(note.embedding, newEmbedding)
    }
}
