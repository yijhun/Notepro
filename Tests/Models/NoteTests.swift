import XCTest
import Foundation
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteInitializationDefaultValues() {
        let note = Note(title: "Default Note")

        XCTAssertEqual(note.title, "Default Note")
        XCTAssertEqual(note.content, "")
        XCTAssertNotNil(note.id)
        XCTAssertNil(note.embedding)
        XCTAssertNil(note.tags)
        XCTAssertNil(note.references)
        XCTAssertNil(note.tasks)
        XCTAssertNil(note.timeBlocks)
        XCTAssertNil(note.linkedNotes)
        XCTAssertNil(note.backlinks)
    }

    func testNoteInitializationCustomValues() {
        let id = UUID()
        let customDate = Date(timeIntervalSince1970: 1000)
        let embedding: [Float] = [0.1, 0.2, 0.3]

        let note = Note(
            id: id,
            title: "Custom Note",
            content: "Hello World",
            createdAt: customDate,
            modifiedAt: customDate,
            embedding: embedding
        )

        XCTAssertEqual(note.id, id)
        XCTAssertEqual(note.title, "Custom Note")
        XCTAssertEqual(note.content, "Hello World")
        XCTAssertEqual(note.createdAt, customDate)
        XCTAssertEqual(note.modifiedAt, customDate)
        XCTAssertEqual(note.embedding, embedding)
    }

    func testNotePropertyMutability() {
        let note = Note(title: "Initial")
        let newDate = Date()
        let newEmbedding: [Float] = [0.9, 0.8, 0.7]

        note.title = "Updated"
        note.content = "New Content"
        note.modifiedAt = newDate
        note.embedding = newEmbedding

        XCTAssertEqual(note.title, "Updated")
        XCTAssertEqual(note.content, "New Content")
        XCTAssertEqual(note.modifiedAt, newDate)
        XCTAssertEqual(note.embedding, newEmbedding)
    }
}
