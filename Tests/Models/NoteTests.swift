import XCTest
import Foundation
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
        let customDate = Date(timeIntervalSince1970: 1000000)
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

        note.title = "Updated Title"
        note.content = "Updated Content"
        note.embedding = [0.5, 0.6]

        XCTAssertEqual(note.title, "Updated Title")
        XCTAssertEqual(note.content, "Updated Content")
        XCTAssertEqual(note.embedding, [0.5, 0.6])
    }
}
