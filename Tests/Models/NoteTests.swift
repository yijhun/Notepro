import XCTest
import SwiftData
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteInitializationDefaultValues() {
        let note = Note(title: "Default Title")

        XCTAssertEqual(note.title, "Default Title")
        XCTAssertEqual(note.content, "")
        XCTAssertNil(note.embedding)
        XCTAssertNil(note.tags)
        XCTAssertNil(note.references)
        XCTAssertNil(note.tasks)
        XCTAssertNil(note.timeBlocks)
        XCTAssertNil(note.linkedNotes)
        XCTAssertNil(note.backlinks)
    }

    func testNoteInitializationCustomValues() {
        let customId = UUID()
        let customDate = Date(timeIntervalSince1970: 1000)
        let customEmbedding: [Float] = [0.1, 0.2, 0.3]

        let note = Note(
            id: customId,
            title: "Custom Title",
            content: "Custom Content",
            createdAt: customDate,
            modifiedAt: customDate,
            embedding: customEmbedding
        )

        XCTAssertEqual(note.id, customId)
        XCTAssertEqual(note.title, "Custom Title")
        XCTAssertEqual(note.content, "Custom Content")
        XCTAssertEqual(note.createdAt, customDate)
        XCTAssertEqual(note.modifiedAt, customDate)
        XCTAssertEqual(note.embedding, customEmbedding)
    }

    func testNotePropertyMutability() {
        let note = Note(title: "Initial Title")

        let newDate = Date()
        let newEmbedding: [Float] = [0.5, 0.5]

        note.title = "New Title"
        note.content = "New Content"
        note.createdAt = newDate
        note.modifiedAt = newDate
        note.embedding = newEmbedding

        XCTAssertEqual(note.title, "New Title")
        XCTAssertEqual(note.content, "New Content")
        XCTAssertEqual(note.createdAt, newDate)
        XCTAssertEqual(note.modifiedAt, newDate)
        XCTAssertEqual(note.embedding, newEmbedding)
    }
}
